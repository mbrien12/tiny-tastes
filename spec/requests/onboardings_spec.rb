require "rails_helper"

RSpec.describe "Onboarding step progression", type: :request do
  let!(:plan) { Plan.create!(name: "Starter", meals_per_week: 5, price_pence: 2999, description: "Test plan") }

  let(:personal_params) do
    { user: { first_name: "Jane", last_name: "Smith", email: "jane@example.com", phone: "07700900000" } }
  end

  def create_onboarding
    post onboardings_path, params: personal_params
    Onboarding.last
  end

  describe "POST /onboardings" do
    it "creates a user and onboarding, then redirects to the wizard" do
      expect { post onboardings_path, params: personal_params }
        .to change(User, :count).by(1)
        .and change(Onboarding, :count).by(1)

      onboarding = Onboarding.last
      expect(onboarding.current_step).to eq("delivery")
      expect(response).to redirect_to(onboarding_path(onboarding.token))
    end

    it "re-renders with errors when personal details are invalid" do
      post onboardings_path, params: { user: { first_name: "", email: "not-an-email" } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Onboarding.count).to eq(0)
    end
  end

  describe "PATCH /onboardings/:token" do
    it "advances from delivery to plan when address is valid" do
      onboarding = create_onboarding

      patch onboarding_path(onboarding.token), params: {
        user: { address_line_1: "12 Meadow Lane", city: "London", postcode: "SW1A 1AA" }
      }

      expect(onboarding.reload.current_step).to eq("plan")
      expect(response).to redirect_to(onboarding_path(onboarding.token))
    end

    it "stays on delivery and returns an error when address is invalid" do
      onboarding = create_onboarding

      patch onboarding_path(onboarding.token), params: {
        user: { address_line_1: "", city: "", postcode: "" }
      }

      expect(onboarding.reload.current_step).to eq("delivery")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "advances from plan to summary when plan details are valid" do
      onboarding = create_onboarding
      patch onboarding_path(onboarding.token), params: {
        user: { address_line_1: "12 Meadow Lane", city: "London", postcode: "SW1A 1AA" }
      }

      patch onboarding_path(onboarding.token), params: {
        user: { plan_id: plan.id, baby_age_years: 1, start_date: Date.tomorrow.to_s }
      }

      expect(onboarding.reload.current_step).to eq("summary")
    end

    it "sets completed_at when confirmed on summary step" do
      onboarding = create_onboarding
      patch onboarding_path(onboarding.token), params: {
        user: { address_line_1: "12 Meadow Lane", city: "London", postcode: "SW1A 1AA" }
      }
      patch onboarding_path(onboarding.token), params: {
        user: { plan_id: plan.id, baby_age_years: 1, start_date: Date.tomorrow.to_s }
      }

      expect { patch onboarding_path(onboarding.token) }
        .to change { onboarding.reload.completed_at }.from(nil)
    end

  end
end
