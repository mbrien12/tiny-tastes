class Onboarding < ApplicationRecord
  belongs_to :user

  STEPS = %w[personal delivery plan summary].freeze

  before_create :assign_token
  after_initialize :set_default_step, if: :new_record?

  def completed?
    completed_at.present?
  end

  def current_step_index
    STEPS.index(current_step) || 0
  end

  def on_summary?
    current_step == "summary"
  end

  private

  def assign_token
    self.token = SecureRandom.uuid
  end

  def set_default_step
    self.current_step ||= "personal"
  end
end
