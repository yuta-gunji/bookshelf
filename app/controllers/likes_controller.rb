# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  # Ajax
  def create
    @target_review = Review.find(params[:review_id])
    @like = current_user.likes.create(review_id: @target_review.id) unless @target_review.already_liked?(current_user)
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
