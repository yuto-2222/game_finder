class GamesController < ApplicationController
  before_action :user_or_admin?
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    # 並び替え方法で分岐
    ## latestで新しい順
    if params[:latest] == "true"
      @games = Game.latest.page(params[:page]).per(8)
    ## earliestで古い順
    elsif params[:earliest] == "true"
      @games = Game.earliest.page(params[:page]).per(8)
    ## popularで人気順
    elsif params[:popular] == "true"
      @games = Game.popular.page(params[:page]).per(8)
    else
      @games = Game.all.page(params[:page]).per(8)
    end

    @genres = Genre.all
  end

  # GET /games/new
  def new
    @game = Game.new
    @genres = Genre.all
  end

  # GET /games/1/edit
  def edit
    @genres = Genre.all
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    if @game.save
      flash[:notice] = 'Success !'
      redirect_to game_reviews_path(@game)
    else
      @genres = Genre.all
      render 'new'
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    if @game.update(game_params)
      redirect_to game_reviews_path(@game)
    else
      @genres = Genre.all
      render 'edit'
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy
    redirect_to games_path
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :release_date, :genre_id, :image)
  end
end
