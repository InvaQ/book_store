class UpdateAddress < Rectify::Command

  def initialize(form, user)
    @form= form
    @params = form[:address]
     @user = user
    #byebug
  end

  def call
    
    return broadcast(:invalid) if form.invalid?    
      broadcast(:ok) if change_address
    #.............
  end

  private
  attr_reader :form

  def change_address   
    binding.pry
    if @user.respond_to?("#{form[:addressable_type]}")
      @user.send("#{form[:addressable_type]}") != nil ? update_address : add_address
    end
  end

  def update_address
     binding.pry
    @user.send("#{form[:addressable_type]}").update(@params)
  end

  def add_address
      binding.pry
    @user.send("create_#{form[:addressable_type]}", @params)
  end

end