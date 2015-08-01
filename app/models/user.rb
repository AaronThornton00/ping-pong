class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email

  has_many :allocations
  has_many :games, through: :allocations

  def number_of_wins
    games.where(winner_id: id).size
  end

  def number_of_losses
    games.where(looser_id: id).size
  end
end
