class PlainViewsController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]
  #load_and_autohrize_resource #cancan method

  # GET /opportunities
  # GET /opportunities.json
  def index
    @opportunities = current_team.evaluations.where(evaluation_code_id: 2).order("id DESC").paginate(:per_page => 50, :page => params[:page])
    @not_evaluated_count = current_team.evaluations.where(evaluation_code_id: 1).count
    @watchlist_count = current_team.evaluations.where(evaluation_code_id: 2).count
    @reject_count = current_team.evaluations.where(evaluation_code_id: 3).count

    #@user = current_user
    #Notifier.status_report(@user).deliver

  end
  # GET /opportunities/1
  # GET /opportunities/1.json

  def show
    @comments = @opportunity.comments
    @comment = Comment.new
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
  end

  # GET /opportunities/1/edit
  def edit
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
      params.require(:opportunity).permit(:opportunity, :class_code, :agency, :opp_type, :post_date, :response_date, :link, :comments, :like, :management_evaluation)
    end
end
