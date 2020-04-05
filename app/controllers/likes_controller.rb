# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  # Ajax
  def create
    @target_review = Review.find(params[:review_id])
    if (current_user.id != @target_review.user_id) && !@target_review.already_liked?(current_user)
      current_user.likes.create(review_id: @target_review.id)
    end
    @target_review.reload
    respond_to do |format|
      format.js
    end
  end

  # Ajax
  def destroy
    @like = Like.includes(:review).find(params[:id])
    @target_review = @like.review
    @like.destroy if @target_review.already_liked?(current_user)
    @target_review.reload
    respond_to do |format|
      format.js
    end
  end
end
