class TagsController < ApplicationController
  before_action :current_tag
  include Pagy::Backend

  def index
    @pagy, @tags = pagy(current_user.tags.order(created_at: :desc), items: 10)
  end

  def new
    @tag = current_user.tags.new
  end

  def create
    @tag = current_user.tags.create(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "Tag created"
    else
      render :new, alert: "Unable to create tag"
    end
  end

  def show
    current_tag
  end

  def edit
  end

  def update
    if current_tag.update(tag_params)
      redirect_to tag_path(current_tag), notice: "Tag updated"
    else
      render :edit, alert: "Unable to update tag"
    end
  end

  def destroy
    current_tag.destroy
    redirect_to tags_path, notice: "Tag deleted"
  end

  private

  def current_tag
    @tag = current_user.tags.find_by(id: params[:id])
  end

  def tag_params
    params.require(:tag).permit(:title)
  end
end
