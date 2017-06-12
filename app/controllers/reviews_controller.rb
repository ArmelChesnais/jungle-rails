class ReviewsController < ApplicationController

  before_filter :user_logged_in

  def create
    prod = Product.find(params[:product_id])
    rev = prod.reviews.new(review_params)
    # rev.product = prod
    rev.user = current_user
    rev.rating = rev.rating.to_i
    if rev.save
      redirect_to prod
    else
      render prod
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
