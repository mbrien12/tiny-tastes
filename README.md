# TinyTastes — Baby Weaning Subscription Wizard

Built for Mindful Chef Rails Engineer Challenge

---

## Setup

**Requirements:** Ruby 3.0.4, Bundler 2.x

```bash
bundle install
rails db:create db:migrate db:seed
rails server    # http://localhost:3000
```


---

## Running Tests

```bash
rspec
```


---

## Design Decisions

### Wizard state in the database
Onboarding state (`current_step`, `completed_at`) lives in a database-backed `onboardings` table rather than the session. This makes it easy to query incomplete onboardings later (e.g. `Onboarding.where(completed_at: nil)`) and provides resume support.

### Token-based URLs
Each onboarding gets a UUID token at creation time. The URL stays the same throughout the wizard (`/onboardings/:token`), so users can return to it without losing progress.

### Step-scoped validations
User model validations use the `on: :context` option so only the relevant fields are validated at each step. The controller calls `@user.valid?(current_step.to_sym)` before advancing. This avoids storing partial validation state and keeps the model clean.

---

## What I'd Improve With More Time

- **Hotwire properly**: Switch from redirect-on-success to `render` with Turbo Stream responses for true in-place step transitions without full page reloads.
- **Error state styling**: Highlight specific input fields with errors rather than just listing messages above the form.
- **Email confirmation**: Send a real confirmation email on `completed_at` using Action Mailer.
- **Postcode validation**: Validate UK postcode format with a regex.
- **Address Autocomplete**: With third party integration
- **Payment integration**: E.g. Stripe
- **Admin view**: List all onboardings with status, filterable by completion, showing conversion funnel drop-off by step.

---

## Architecture

```
app/
  controllers/
    onboardings_controller.rb   # new, create, show, update
  models/
    plan.rb                     # seeded reference data (3 tiers)
    user.rb                     # step-scoped validations
    onboarding.rb               # wizard state (token, current_step, completed_at)
  views/
    layouts/application.html.haml
    onboardings/
      new.html.haml             # landing + step 1 personal details form
      show.html.haml            # shell — renders current step partial
      _progress_bar.html.haml   # Step N of 3 indicator
      _personal.html.haml       # Step 1 edit form (reached via back navigation)
      _delivery.html.haml       # Step 2 form
      _plan.html.haml           # Step 3 card-style plan selector
      _summary.html.haml        # Read-only confirmation + Confirm button
      _completed.html.haml      # Post-confirmation thank you
config/
  routes.rb                     # root → new, resources :onboardings param: :token
db/
  seeds.rb                      # 3 Plan records (Starter, Growing, Family)
spec/
  models/plan_spec.rb           # Validates model methods for Plan
  spec/requests/onboardings_spec.rb  # Tests onboarding step progression
```
