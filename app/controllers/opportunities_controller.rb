class OpportunitiesController < ApplicationController
  filter_resource_access :to => :index

  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

  # GET /opportunities
  # GET /opportunities.json
  def index
    if current_user
      #params[:set_filter]="1" if params[:set_filter].blank?
      #@evaluated_opportunities = current_team.evaluations.where(evaluation_code_id:params[:set_filter]).order("opportunity_id DESC").paginate(:per_page => 50, :page => params[:page]) 
      @active_team = Team.find(current_user.team_id)
    else
      #@q = Opportunity.search(params[:q])
      #@opportunities = @q.result(distinct: true).order("id DESC").paginate(:per_page => 50, :page => params[:page])
    end
  end

  def search
    index
    render :index
  end
  
  # GET /opportunities/1
  # GET /opportunities/1.json

  def increment
    @opportunity = Opportunity.find(params[:id])
    @opportunity.like += 1
    @opportunity.management_evaluation = "Watchlist"
    @opportunity.save
    @opptag = "#likes-#{@opportunity.id}"
    respond_to do |format|
      format.js
    end
  end

  def decrement
    @opportunity = Opportunity.find(params[:id])
    @opportunity.like -= 1
    @opportunity.save
    @opptag = "#likes-#{@opportunity.id}"
    respond_to do |format|
      format.js
    end
  end


  def show
    if current_user
      @opportunity_evaluation = current_team.evaluations.find_by(opportunity_id: @opportunity.id)
    end
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
    @teams = Team.all 
  end

  # GET /opportunities/1/edit
  def edit
    @teams = Team.all
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    @opportunity = Opportunity.new(opportunity_params)

    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @opportunity }
      else
        format.html { render action: 'new' }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    respond_to do |format|
      if @opportunity.update(opportunity_params)
        format.html { redirect_to @opportunity, notice: "Updated Management Evaluation for: #{@opportunity.opportunity[0..20]}....." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    @opportunity.destroy
    respond_to do |format|
      format.html { redirect_to opportunities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      params.require(:opportunity).permit(:opportunity, :class_code, :agency, :opp_type, :post_date, :response_date, :link, :comments, :like, :management_evaluation, :team_ids =>[], :opportunity_ids=>[])
      #params.require(:comment).permit(:comment, :name, :opportunity_id)
    end
end
