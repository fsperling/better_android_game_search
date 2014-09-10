class GamesController < ApplicationController
 
  def show
    @game = Game.find(params[:id])
    @category_names = @game.categories.map(&:name)
  end

  def new
    @game = Game.new
    @categories = Category.all
    
    3.times do
      @game.screenshots.build
    end
  end
  
  def create
    @game = Game.new(user_params)
    if @game.save
      @game.category_ids = user_params[:category_ids]
      flash[:success] = "Thanks! Your game has been saved!"
      redirect_to @game
    else
      render 'new'
    end
  end

  def index
    @games = Game.paginate(page: params[:page])
  end
  
  def edit
    @game = Game.find(params[:id])
    @game.screenshots.build
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(user_params)
      flash[:success] = "Game updated"
      redirect_to @game
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:game).permit(:name, :description, :version, :email, 
          :webpage, :banner_icon_url, :banner_image_url, screenshots_attributes: [:id, :url, :_destroy], category_ids: [])
    end
end
