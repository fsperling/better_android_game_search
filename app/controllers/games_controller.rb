class GamesController < ApplicationController
 
  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end
  
  def create
    @game = Game.new(user_params)
    if @game.save
      flash[:success] = "Thanks! Your game has been saved!"
      redirect_to @game
    else
      render 'new'
    end
  end

  def index
    @games = Game.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:game).permit(:name, :description)
    end
end
