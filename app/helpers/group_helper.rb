module GroupHelper

  def score(game, player_1, player_2)
    "#{game.player_score(player_1)}:#{game.player_score(player_2)}"
  end

end
