module Spree
  module Admin
    
    class CouponsImportController < BaseController

      def new
        @coupons_import = Spree::CouponsImport.new
      end
      
      def create
        filename=params[:coupons_import][:file].path  
        keys = File.readlines(filename)
        products = []
        params[:coupons_import][:product].split(',').each do |product_id|
          products << Spree::Product.find(product_id)
        end
        variants = Spree::Variant.where(product_id: products.pluck(:id))
        end_promo = Spree::SalesSchedule.where(variant_id: variants).order(:end_time).max[:end_time] rescue products.map{|p| p.discontinue_on}.max
        start_promo = products.map{ |p| p.available_on }.min
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
              starts_at: start_promo,
              expires_at: end_promo,
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
            promotion_rule.products << products
            @results << {code: code, status: true}
          else
            @results << {code: code, status: false}
          end
        end
      end
        
    end
  end
end