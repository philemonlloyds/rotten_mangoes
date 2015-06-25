class MoviesController < ApplicationController

  def index
    @movies = Movie.search(params[:search])
    case params[:duration].to_i
    when 1
      @movies = @movies.minutes_under_90
    when 2
      @movies = @movies.minutes_between_90_120
    when 3
      @movies = @movies.minutes_over_120
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def search
    # @movies || = find_movies
    # if params[:qt]!=""
    #   @movies = Movie.where("title like ?", "%#{params[:qt]}%")
    # elsif params[:qd]!=""
    #   @movies = Movie.where("director like ?", "%#{params[:qd]}%")
    # else
    #   if params[:Duration] == "Under 90 minutes"
    #     @movies = Movie.where("runtime_in_minutes  <= ?", 90)
    #   elsif params[:Duration] =="Between 90 and 120 minutes"
    #     @movies = Movie.where("runtime_in_minutes = ? OR runtime_in_minutes <= ?", 90,120)
    #   else
    #     @movies = Movie.where("runtime_in_minutes  > ?", 120)
    #   end
    # end
    # redirect_to movies_path(@movies)
  end

  def find_movies
    search = Movie.scoped({})
    # scope = scope.scoped conditions:
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description,:remote_image_url
    )
  end

end
