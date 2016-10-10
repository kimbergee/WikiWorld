class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Wiki World Premium Membership - #{current_user.username}",
      amount: 15_00
    }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge

    if current_user.customer_id
      customer = Stripe::Customer.retrieve(current_user.customer_id)
    else
      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
      )
    end

    if current_user.premium!
      charge = Stripe::Charge.create(
        customer: customer.id, # Note -- this is NOT the user_id in your app
        amount: 15_00,
        description: "BigMoney Membership - #{current_user.email}",
        currency: 'usd'
      )
      # TODO: Handle failed charge. If charge failed, then revert to standard
      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
      redirect_to user_path(current_user) # or wherever
    else
      # Handle Error here
      flash[:error] = "There was an error, please try again"
      redirect_to user_path(current_user)
    end

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

end
