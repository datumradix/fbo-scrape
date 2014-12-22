class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_filter :set_current_user
  #before_action :search_params

  before_filter :set_search 

  def set_search
    @search = Opportunity.search(params[:q])
    @opportunities = @search.result(distinct: true).order("id DESC").paginate(:per_page => 50, :page => params[:page])
  end

  before_filter { |c| Authorization.current_user = c.current_user}

  helper_method :current_user

  def require_no_user
    if current_user
      flash[:notice] = "You must be logged out to access the password reset page"
      redirect_to root_path
      return false
    end
  end

  def current_team
    return @current_team = Team.find(current_user.team_id) if current_user
  end

  protected
  #def search_params
  #  @q = Opportunity.search(params[:q])
  #  @opportunities = @q.result(distinct: true)
  #end

  def set_current_user
    Authorization.current_user = current_user 
  end
  
  def current_user_session
  	return @current_user_session if defined?(@current_user_session)
  	@current_user_session = UserSession.find
  end

  def current_user
  	return @current_user if defined?(@current_user)
  	@current_user = current_user_session && current_user_session.record
  end

  def permission_denied
    flash[:error] = "You do not have permissions to go here."
    redirect_to new_user_session_path
  end

end
