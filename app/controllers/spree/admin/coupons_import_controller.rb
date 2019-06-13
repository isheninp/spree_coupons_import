module Spree
  module Admin
    class CouponsImportController < BaseController

      def new
        @coupons_import = Spree::CouponsImport.new
      end
      
      def create

#<ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"SRkxpMwMvbr5yoaLwwZe2pzLoTSDjPm832VBzSv9i37/R8IWXZgSUI5r9cMt/aOfE44NIY4tUbUuMKAl8IZIaw==", 

#"coupons_import"=>{
"promo_name"=>"ываыва", 
"promo_desc"=>"ываыва ыв ыв аыв", 
"product"=>"1", 
"file"=>#<ActionDispatch::Http::UploadedFile:0x00007f8940059940 @tempfile=#<Tempfile:/tmp/RackMultipart20190613-1605-m5pdpc.txt>, 
@original_filename="code.txt", 
@content_type="text/plain", 
@headers="Content-Disposition: form-data; name=\"coupons_import[file]\"; filename=\"code.txt\"\r\nContent-Type: text/plain\r\n">, 

"percent"=>"100"}, "controller"=>"spree/admin/coupons_import", "action"=>"create"} permitted: false>

        p '-----------'
        pp params
        
        filename = "code.txt"
        
        
        
      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        render json: {result: "sdfsdf"}
      end

def qq
         filename = "code.txt"
    keys = File.readlines(filename)
    promo_product = Spree::Product.find 1
    keys.take(5).each do |c|
      code = c.strip
      p "Trying to create promotion with code #{code}"
      if Spree::Promotion.where('code=?', code).count == 0
        promotion = Spree::Promotion.create!({
          name: 'DESCRIPTIVE NAME FOR PROMOTION HERE',
          description: 'DESCRIPTIVE ... DESCRIPTION?',
          match_policy: 'all',
          usage_limit: '1',
          starts_at: '2018-12-04 00:00:00',
          expires_at: '2020-12-04 00:00:00',
          code: code
        })
        promotion.promotion_actions << Spree::Promotion::Actions::CreateAdjustment.create({
          calculator: Spree::Calculator::PercentOnLineItem.new(preferred_percent: 100) 
        })
        promotion_rule = Spree::Promotion::Rules::Product.new({
          promotion_id: promotion.id
        })
        promotion_rule.promotion = promotion
        promotion_rule.save  
        promotion_rule.products << promo_product
        p 'done.'
      else
        p "Code #{code} already exists"
      end
    end
end

      
    end
  end
end