class GamesController < ApplicationController
  # before_filter :create, :check_number_of_players

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @users = User.all
  end

  def create
    @game = Game.new
    raise params.inspect
    @game.users = params[:allocations]
    if @game.save
      redirect_to games_path
    else
      render 'new'
    end
  end


  private

  def check_number_of_players
    raise 'wrong number of players' unless params[:allocations].length == 2
  end

end
