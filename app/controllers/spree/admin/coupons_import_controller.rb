module Spree
  module Admin
    
    class CouponsImportController < BaseController

      def new
        @coupons_import = Spree::CouponsImport.new
      end
      
      def create
        filename=params[:coupons_import][:file].path  
        keys = File.readlines(filename)
        product = Spree::Product.find params[:coupons_import][:product]
        variants = Spree::Variant.where('product_id=?', product.id)
        end_z = Spree::SalesSchedule.where(variant_id: variants).order(:end_time).max[:end_time] rescue product.discontinue_on 
        percent = params[:coupons_import][:percent].to_i
        @results = []
        keys.each do |c|
          code = c.strip
          if Spree::Promotion.where('code=?', code).count == 0
            promotion = Spree::Promotion.create!({
              name: params[:coupons_import][:promo_name],
              description: params[:coupons_import][:promo_desc],
              match_policy: 'all',
              usage_limit: '1',
              starts_at: product.available_on,
              expires_at: end_z,
              code: code
            })
            promotion.promotion_actions << Spree::Promotion::Actions::CreateAdjustment.create({
              calculator: Spree::Calculator::PercentOnLineItem.new(preferred_percent: percent) 
            })
            promotion_rule = Spree::Promotion::Rules::Product.new({
              promotion_id: promotion.id
            })
            promotion_rule.promotion = promotion
            promotion_rule.save  
            promotion_rule.products << product
            @results << {code: code, status: true}
          else
            @results << {code: code, status: false}
          end
        end
      end
        
    end
  end
end