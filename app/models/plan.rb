class Plan < ApplicationRecord
  has_many :users

  def price_display
    "£#{format('%.2f', price_pence / 100.0)}"
  end
end
