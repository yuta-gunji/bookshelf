# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  # Ajax
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    @followers = @user.followers.reload
    respond_to do |format|
      format.js
    end
  end

  # Ajax
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    @followers = @user.followers.reload
    respond_to do |format|
      format.js
    end
  end
end
