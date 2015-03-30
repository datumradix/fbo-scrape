class OpportunityTypesController < ApplicationController
  before_action :set_opportunity_type, only: [:show, :edit, :update, :destroy]

  # GET /opportunity_types
  # GET /opportunity_types.json
  def index
    @opportunity_types = OpportunityType.all
  end

  # GET /opportunity_types/1
  # GET /opportunity_types/1.json
  def show
  end

  # GET /opportunity_types/new
  def new
    @opportunity_type = OpportunityType.new
  end

  # GET /opportunity_types/1/edit
  def edit
  end

  # POST /opportunity_types
  # POST /opportunity_types.json
  def create
    @opportunity_type = OpportunityType.new(opportunity_type_params)

    respond_to do |format|
      if @opportunity_type.save
        format.html { redirect_to @opportunity_type, notice: 'Opportunity type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @opportunity_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @opportunity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunity_types/1
  # PATCH/PUT /opportunity_types/1.json
  def update
    respond_to do |format|
      if @opportunity_type.update(opportunity_type_params)
        format.html { redirect_to @opportunity_type, notice: 'Opportunity type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @opportunity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunity_types/1
  # DELETE /opportunity_types/1.json
  def destroy
    @opportunity_type.destroy
    respond_to do |format|
      format.html { redirect_to opportunity_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity_type
      @opportunity_type = OpportunityType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_type_params
      params.require(:opportunity_type).permit(:name)
    end
end
