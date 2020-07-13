class Company < ApplicationRecord
  has_rich_text :description
  include CompanyConcern

  def address
    "#{city}, #{state}"
  end
end
