class Onboarding < ApplicationRecord
  belongs_to :user
  #Q - should a user exist in the db before wizard completes? To avoid ghost/duplicate users and track funnel conversion with event analytics?

  STEPS = %w[personal delivery plan summary].freeze
  #Todo - enum for current_step

  before_create :assign_token
  after_initialize :set_default_step, if: :new_record?

  scope :incomplete, -> { where(completed_at: nil) }
  scope :drop_off_by_step, -> { incomplete.group(:current_step) }
  #Todo - add started_at timestamp to calc time to complete

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
