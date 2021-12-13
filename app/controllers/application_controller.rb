class ApplicationController < ActionController::Base
  before_action :set_query_search

  def set_query_search
    @q = Product.search(params[:q])
  end
end
