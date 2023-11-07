class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    @games = Game.all
    @rating = '評価'
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
      flash[:success] = "新しいゲームが追加されました！"
      redirect_to games_path
    else
      flash.now[:danger] = "ゲームの追加に失敗しました。"
      @genres = Genre.all
      render 'new'
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    if @game.update(game_params)
      flash[:success] = "ゲーム詳細がアップデートされました！"
      redirect_to game_reviews_path(@game)
    else
      flash.now[:danger] = "ゲーム内容の編集ができませんでした。"
      @genres = Genre.all
      render 'edit'
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :release_date, :genre_id)
    end
end
