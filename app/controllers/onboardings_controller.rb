class OnboardingsController < ApplicationController
  before_action :find_onboarding, only: [:show, :update]

  def new

  end

  def create
    @user = User.new(personal_params)

    if @user.save(context: :personal)
      @onboarding = Onboarding.create!(user: @user, current_step: "delivery")
      redirect_to onboarding_path(@onboarding.token)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    render :show
  end

  def update
    if params[:direction] == "back"
      go_back
      return
    end

    if @onboarding.on_summary?
      complete_onboarding
    else
      advance_onboarding
    end
  end

  private

  def find_onboarding
    @onboarding = Onboarding.find_by!(token: params[:token])
    @user = @onboarding.user
  end

  def personal_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone)
  end

  def delivery_params
    params.require(:user).permit(:address_line_1, :address_line_2, :city, :postcode)
  end

  def plan_params
    params.require(:user).permit(:plan_id, :baby_age_years, :start_date)
  end

  def step_params
    case @onboarding.current_step
    when "personal" then personal_params
    when "delivery" then delivery_params
    when "plan"     then plan_params
    else {}
    end
  end

  def advance_onboarding
    @user.assign_attributes(step_params)
    context = @onboarding.current_step.to_sym

    if @user.save(context: context)
      next_step = Onboarding::STEPS[Onboarding::STEPS.index(@onboarding.current_step) + 1]
      @onboarding.update!(current_step: next_step)
      redirect_to onboarding_path(@onboarding.token)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def go_back
    prev_step = Onboarding::STEPS[Onboarding::STEPS.index(@onboarding.current_step) - 1]
    @onboarding.update!(current_step: prev_step) if prev_step
    redirect_to onboarding_path(@onboarding.token)
  end

  def complete_onboarding
    @onboarding.update!(completed_at: Time.current)
    redirect_to onboarding_path(@onboarding.token)
  end
end
