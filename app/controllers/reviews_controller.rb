class ReviewsController < ApplicationController

  before_filter :current_user

  def create
    @product = Product.find(params[:product_id])
    rev = @product.reviews.new(review_params)
    rev.user = current_user
    rev.rating = rev.rating.to_i
    if rev.save
      redirect_to @product
    else
      render "products/show"
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to Product.find(params[:product_id]), notice: 'Review deleted!'
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

  def user_logged_in
    current_user
  end
end
