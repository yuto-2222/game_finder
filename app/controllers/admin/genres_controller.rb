class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre, only: %i[ edit update ]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render 'index'
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      flash[:notice] = 'Failed'
      render 'edit'
    end
  end


  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
