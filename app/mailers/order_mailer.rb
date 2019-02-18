class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_place_confirmation.subject
  #
  def order_not_approved(user)
    @user = user

    mail to: @user.email, subject: "Order Cancel"
  end
  def order_place_confirmation(user)
    @user = user

    mail to: @user.email, subject: "Tick Tick Order Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_confirmation.subject
  #
  def order_confirmation(user)
    @user = user

    mail to: @user.email , subject: "Order Approval"
  end
end
