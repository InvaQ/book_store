class UpdateAddress < Rectify::Command

  def initialize(form, object)
    @form= form
    @params = form[:address]
     @object = object
  end

  def call
    
    return broadcast(:invalid) if form.invalid?    
      broadcast(:ok) if change_address
    #.............
  end

  protected
  attr_reader :form

  def change_address
    binding.pry
    if @object.respond_to?("#{form[:addressable_type]}")
      @object.send("#{form[:addressable_type]}") != nil ? update_address : add_address
    end
  end

  def update_address
    @object.send("#{form[:addressable_type]}").update(@params)
  end

  def add_address
    @object.send("create_#{form[:addressable_type]}", @params)
  end

end