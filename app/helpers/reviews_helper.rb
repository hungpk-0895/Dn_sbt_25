module ReviewsHelper
  def load_comment_of_tour tour
    @comments = tour.reviews.parent_comment.paginate(page: params[:page],
      per_page: Settings.limit_page.comments)
  end

  def load_reply_comment tour, cmt_id
    @reply_comments = tour.reviews.sub_comment(cmt_id)
  end
end
