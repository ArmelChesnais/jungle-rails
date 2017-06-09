class UserMailerPreview < ActionMailer::Preview

  def order_email
    UserMailer.order_email(User.find(2), Order.first)
  end
end
