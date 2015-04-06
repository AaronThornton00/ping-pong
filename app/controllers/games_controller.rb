class GamesController < ApplicationController

  def index
    @games = Game.all.sort_by(&:start_at).reverse
  end

  def new
    @game = Game.new
    @users = User.all
  end

  def create
    @game           = Game.new
    player_1        = User.find(params[:game][:player_1][:id])
    player_2        = User.find(params[:game][:player_2][:id])
    player_1_score  = params[:game][:player_1][:score].to_i
    player_2_score  = params[:game][:player_2][:score].to_i
    @game.players   = [player_2, player_1]
    @game.start_at  = convert_from_milliseconds(params[:game][:start_at])
    @game.end_at    = convert_from_milliseconds(params[:game][:end_at])
    @game.duration  = @game.end_at - @game.start_at
    @game.winner_id = (player_1_score > player_2_score) ? player_1.id : player_2.id
    @game.looser_id = (player_1_score < player_2_score) ? player_1.id : player_2.id
    @game.save!
    @game.update_player_score(player_1, player_1_score)
    @game.update_player_score(player_2, player_2_score)
    render json: {}
  end


  private

  def convert_from_milliseconds(ms)
    Time.strptime((ms.to_f/1000).to_s, '%s')
  end

end
