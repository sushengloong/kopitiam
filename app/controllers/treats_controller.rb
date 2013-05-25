class TreatsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # def new
  #   @topic = Topic.find params[:topic_id]
  #   render layout: false
  # end

  def create
    treat = Treat.create topic_id: params[:topic_id], name: params[:name], value: 1, user_id: current_user.id
    topic = Topic.find treat.topic_id
    render json: { status: :ok, topic_treat_score: topic.treat_score }.to_json
  end
end
