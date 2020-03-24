class YearsController < ApplicationController
  def index
    @years = Year.all
  end

  def show
    @year = params.require(:id)
  end
end
