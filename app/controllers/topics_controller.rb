require 'link_thumbnailer'

class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :preview]

  # GET /topics
  # GET /topics.json
  def index
    # TODO Duplicate code. Must refactor
    if params[:tab].present?
      @topics = case params[:tab]
                when 'popular-topics'
                  Topic.popular.page(params[:page])
                when 'fresh-topics'
                  Topic.fresh.page(params[:page])
                end
    else
      if params[:q].present?
        @search_topics = Topic.popular.page(params[:page])
      end
      @popular_topics = Topic.popular.page(params[:page])
      @fresh_topics = Topic.fresh.page(params[:page])
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @comment = current_user ? @topic.comments.new(user: current_user) : nil
  end

  # GET /topics/new
  def new
    @topic = current_user.topics.build
  end

  # GET /topics/1/edit
  def edit
  end

  def preview
    begin
      link_thumbnailer = LinkThumbnailer.generate(params[:link])
    rescue URI::InvalidURIError, Net::HTTP::Persistent::Error
      link_thumbnailer = nil
    end
    link_thumbnailer = if link_thumbnailer.blank?
                       {}
                     else
                       link_thumbnailer = link_thumbnailer.to_hash # it's easier to reassign values in hash
                       link_thumbnailer["images"] = link_thumbnailer["images"].map { |image| image[:source_url].to_s }
                       link_thumbnailer.to_json
                     end
    render json: link_thumbnailer
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = current_user.topics.build(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :text, :link, :thumbnail)
    end
end
