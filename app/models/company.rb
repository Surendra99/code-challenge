class Company < ApplicationRecord
  has_rich_text :description
  include CompanyConcern
end
