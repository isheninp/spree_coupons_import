module Spree
  class CouponsImport
    
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    attr_accessor :promo_name, :promo_desc, :product, :file, :percent, :amount
    validates_presence_of :product, :file

    validates :percent, presence: true, unless: :amount
    validates :amount, presence: true, unless: :percent
    
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      false
    end
    
  end
end
