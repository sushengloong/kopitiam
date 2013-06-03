class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.create topic_id: params[:topic_id]
    track_activity @favorite, 'create'
    render 'create.js'
  end
end
