module EmailValidator
    extend ActiveSupport::Concern
    included do 
        validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@getmainstreet.com\z/, 
                              message: I18n.t('company.invalid_email'), allow_blank: true}
    end
end