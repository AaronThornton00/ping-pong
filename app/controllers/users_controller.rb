class UsersController < ApplicationController

  def index
    @users = User.all.sort_by(&:number_of_wins).reverse
  end

  def show
    @user = User.find(params[:id])
  end
end
