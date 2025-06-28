class SearchController < ApplicationController
  def index
    @query = search_params[:query]

    if @query.present?
      @search_tasks = current_user.tasks.search_for_title(@query)
      @search_projects = current_user.projects.search_for_title(@query)
      @search_tags = current_user.tags.search_for_title(@query)
    else
      @search_tasks = []
      @search_projects = []
      @search_tags = []
    end
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
