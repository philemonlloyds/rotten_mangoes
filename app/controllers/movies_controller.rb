class MoviesController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  def index
    @movies = Movie.all
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

  def update
    @movie = Movie.find(params[:id])

   if @movie.update(movie_params)
     redirect_to @movie
   else
     render 'edit'
   end

  end

  def create
     @movie = Movie.new(movie_params)
     @movie.save
    if @movie.save
      redirect_to @movie
    else
      render 'new'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

private
  def movie_params
    params.require(:movie).permit(:title, :director,:runtime_in_minutes,:description,:poster_image_url,:release_date)
  end

end
