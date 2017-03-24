class AddressesPresenter < Rectify::Presenter
  def initialize(address_type = nil, address_form = nil)
    instance_variable_set("@#{address_type}_form", address_form)
    super()
  end

    def billing
      @billing ||= address(:billing)
    end

    def shipping
      @shipping ||= address(:shipping)
    end

    private

    def address(type)
      instance_variable_get("@#{type}_form") || current_user.send("#{type}_address") ||
        "#{type.capitalize}Address".constantize.new
    end
end