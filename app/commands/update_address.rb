class UpdateAddress < Rectify::Command

  def initialize(form)
    @form = form
    #byebug
  end

  def call
    
    return broadcast(:invalid) if form.invalid?

    transaction do
      change_address
    end
    broadcast(:ok)
  end

  private
  attr_reader :form

  def change_address
    @user = current_user
    byebug
    if @user.respond_to?("#{form[:addressable_type]}")
      @user.send("#{form[:addressable_type]}") != nil ? update_address : add_address
    end
  end

  def update_address
    byebug
    @user.send("#{form[:addressable_type]}").update(params[:address])
  end

  def add_address
     byebug
    @user.send("create_#{form[:addressable_type]}", params[:address])
  end

  def countries_list(countries)
    countries.map do |country|
      [country.name, country.id, {data: {code: country.code}}]
    end
  end

end