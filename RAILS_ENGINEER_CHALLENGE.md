# Rails Engineer Interview Challenge

Thank you for taking the time to interview with us. This document outlines the challenge you will complete as part of the interview process. The goal is to assess your Ruby on Rails skills across the full stack, as well as your ability to build a polished, user-friendly product.

## Challenge Overview

Build a multi-step onboarding wizard for a fictional subscription service. A potential customer should be able to step through a series of screens, entering their information progressively, and ultimately see a summary of what they've provided.

This challenge tests your ability to work across models, controllers, and views in Rails while keeping the user experience smooth and the code well-organised.

The appetite for this challenge is around 2 hours, and you should adjust scope accordingly. If you find yourself running out of time, please submit what you have completed, and we will review it.

## Requirements

Your onboarding wizard must:

1. Consist of at least 3 steps (e.g., personal details, address, preferences).
2. Allow the user to move forward and back between steps without losing their input.
3. Validate the relevant fields at each step before allowing the user to proceed.
4. Display a summary/confirmation screen at the end showing everything the user has entered.
5. Feel cohesive - transitions between steps should be clear and the UI should guide the user confidently through the flow.

## Technical Implementation

- Use Ruby on Rails (a recent version you're comfortable with).
- Use server-rendered views (ERB or your preferred Rails templating engine). Hotwire/Turbo is welcome but not required.
- Store onboarding state in the database - not solely in the session or client-side.
- Keep your data model(s) sensible. Think about how you'd query incomplete onboardings later.
- Write at least a few meaningful tests (model validations, a request spec for step progression, or similar). Full coverage is not expected in 2 hours - just show us how you approach testing.

## Bonus Points (Optional)

If you have extra time, consider implementing:

- A progress indicator showing the user which step they're on and how many remain.
- Hotwire/Turbo for snappier step transitions without full page reloads.
- An admin-facing view that lists all onboardings and their completion status.
- Resume support - if a user returns to the wizard URL, they pick up where they left off.
- Your own idea for enhancing the user experience.

## Use of AI Tools

You're welcome to use AI-assisted tools (Claude, ChatGPT, etc.) the same way you would in your day-to-day work. Just be prepared to walk through your implementation in detail and explain the choices you made.

## Submission Guidelines

You can submit your solution in one of the following ways:

- Create a public GitHub repository and share the link.
- Zip your project files and email them to us.

Please ensure your code is well-organised, commented where intent isn't obvious, and follows Rails conventions. Include a README with instructions on how to set up and run your project, any design decisions you made, what you would improve with more time, and any known issues.

## Questions?

If anything is unclear, please ask! We are here to help you succeed in this challenge. Good luck, and we look forward to seeing your solution!
