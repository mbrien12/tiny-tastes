class User < ApplicationRecord
  belongs_to :plan, optional: true
  has_one :onboarding

  validates :first_name, :last_name, :email, :phone, presence: true, on: :personal
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :personal
  validates :email, uniqueness: true, on: :personal

  validates :address_line_1, :city, :postcode, presence: true, on: :delivery

  validates :plan_id, :baby_age_years, :start_date, presence: true, on: :plan
  validates :baby_age_years, numericality: { in: 0..3, allow_nil: true }, on: :plan
end
