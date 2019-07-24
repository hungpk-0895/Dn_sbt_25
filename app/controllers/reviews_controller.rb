class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :load_tour

  def create
    @comment = current_user.reviews.build comment_params
    if @comment.save
      @reply_comment = Review.new
      check_comment @comment
    else
      flash[:danger] = t ".error"
      redirect_to tour_path(@tour)
    end
  end

  private
  def comment_params
    params.require(:review).permit(:user_id, :tour_id, :comment_content,
      :comment_at, :reply_comment)
  end

  def load_tour
    @tour = Tour.find_by id: params[:review][:tour_id]
    return if @tour
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def check_comment comment
    if comment.reply_comment.zero?
      respond_to do |format|
        format.html{redirect_to tour_path(@tour)}
        format.js{render "create_comment"}
      end
    else
      respond_to do |format|
        format.html{redirect_to tour_path(@tour)}
        format.js{render "reply_comment"}
      end
    end
  end
end
