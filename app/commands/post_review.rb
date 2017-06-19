class PostReview < Rectify::Command

  def initialize(book, user, params)
    @book= book
     @user = user
     @params = params
     
  end

  def call
    review_form

    return broadcast(:invalid, form) if @form.invalid?    
      broadcast(:ok) if post_review
  end

  private
    attr_reader :form, :params

  def review_form
    @form = ReviewForm.from_params(params)    
  end

  

  def post_review
    review = @form.attributes.merge(book_id: @book.id, user_id: @user.id)   
    Review.create(review)
  end

end