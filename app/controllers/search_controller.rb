class SearchController < ApplicationController

def index
  @results = SearchData.all
  if params[:search_field].present?
    @results = SearchData.search(params[:search_field])
  end
  
end

def execute
  
end

end
