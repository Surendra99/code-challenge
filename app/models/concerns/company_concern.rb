module CompanyConcern
    extend ActiveSupport::Concern
    
    included do 
        validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@getmainstreet.com\z/, 
                              message: I18n.t('company.invalid_email'), allow_blank: true}

        validate :zip_code_should_be_valid

        before_save :update_city_and_state
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