class StepAddressPresenter < Rectify::Presenter
  def initialize(current_user, order, billing=nil, shipping=nil)
    @billing = billing
    @shipping = shipping
    @order = order
    @user = current_user
    super()
  end


  def billing
    @billing ||= priority_address('billing')
  end

  def shipping
    @shipping ||= priority_address('shipping')  
  end
  private

  def priority_address(type)
    @order.public_send("#{type}_address") || @user.public_send("#{type}_address") || "#{type.capitalize}Address".constantize.new
  end



end