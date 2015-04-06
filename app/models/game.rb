class Game < ActiveRecord::Base
  has_many :allocations
  has_many :players, through: :allocations, source: :user

  def player_score(player)
    allocations.find_by(user_id: player.id).score
  end
end
