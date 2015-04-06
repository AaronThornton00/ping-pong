class Game < ActiveRecord::Base
  has_many :allocations
  has_many :players, through: :allocations, source: :user
  has_one :winner, class: :user
  has_one :losser, class: :user

  validates_presence_of :start_at, :end_at

  def player_score(player)
    allocations.find_by(user_id: player.id).score
  end

  def update_player_score(player, score)
    allocations.find_by(user_id: player.id).update_attribute(:score, score)
  end
end
