class SearchController < ApplicationController
  def search
    if params[:qt]!=""
      @movies = Movie.where("title like ?", "%#{params[:qt]}%")
    elsif params[:qd]!=""
      @movies = Movie.where("director like ?", "%#{params[:qd]}%")
    else
      if params[:Duration] == "Under 90 minutes"
        @movies = Movie.where("runtime_in_minutes  <= ?", 90)
      elsif params[:Duration] =="Between 90 and 120 minutes"
        @movies = Movie.where("runtime_in_minutes = ? OR runtime_in_minutes <= ?", 90,120)
      else
        @movies = Movie.where("runtime_in_minutes  > ?", 120)
      end
    end

  end
end
