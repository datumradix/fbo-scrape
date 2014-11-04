class StaticPagesController < ApplicationController
  def about
  end

  def help
    @current_team = current_team
  end

  def private_team
  end
  
end
