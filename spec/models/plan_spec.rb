require "rails_helper"

RSpec.describe Plan, type: :model do
  describe "#price_display" do
    it "formats pence as pounds with two decimal places" do
      plan = Plan.new(price_pence: 2999)
      expect(plan.price_display).to eq("£29.99")
    end

    it "formats a round pound amount correctly" do
      plan = Plan.new(price_pence: 5000)
      expect(plan.price_display).to eq("£50.00")
    end
  end
end
