class Company < ApplicationRecord
  has_rich_text :description
  include EmailValidator
  include ZipCodeHandler

  def address
    "#{city}, #{state}"
  end
end
