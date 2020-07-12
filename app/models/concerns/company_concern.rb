module CompanyConcern
    extend ActiveSupport::Concern
    
    included do 
        validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@getmainstreet.com\z/, 
                              message: 'Only getmainstreet.com domain emails are allowed.', allow_blank: true}

        validate :zip_code_should_be_valid

        before_save :add_city_state_info
    end

    private
    def zip_code_should_be_valid
        errors.add(:zip_code, 'Zip Code is not valid') unless ZipCodes.identify(zip_code).present?
    end

    def add_city_state_info
        zip_code_info = ZipCodes.identify(zip_code)
        self.city = zip_code_info[:city]
        self.state = zip_code_info[:state_code]
    end
end