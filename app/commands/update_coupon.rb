class UpdateCoupon < Rectify::Command

  def initialize(params, object, code_blank = true)
    @params = params
    @order = object
    @code_blank = code_blank
  end

  def call
    use_coupon! if need_update?
  end

  private
    attr_reader :params

    def need_update?
      !@code_blank || @order.coupon&.code != params[:code]
    end

    def use_coupon!
      @order.coupon = Coupon.find_by_code(params[:code])
    end

	end