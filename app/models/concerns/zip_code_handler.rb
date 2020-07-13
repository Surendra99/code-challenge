module ZipCodeHandler
    extend ActiveSupport::Concern
    
    included do 
        before_save :update_city_and_state
        validate :zip_code_should_be_valid
    end
    

    private
    def zip_code_should_be_valid
        errors.add(:zip_code, I18n.t('company.invalid_zip_code')) unless ZipCodes.identify(zip_code).present?
    end

    def update_city_and_state
        zip_code_info = ZipCodes.identify(zip_code)
        self.city = zip_code_info[:city]
        self.state = zip_code_info[:state_code]
    end
end