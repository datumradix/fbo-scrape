class SelectionCriteriaController < ApplicationController
  before_action :set_selection_criterium, only: [:show, :edit, :update, :destroy]
  filter_resource_access

  # GET /selection_criteria
  # GET /selection_criteria.json
  def index
    @selection_criteria = SelectionCriterium.all
  end

  # GET /selection_criteria/1
  # GET /selection_criteria/1.json
  def show
  end

  # GET /selection_criteria/new
  def new
    @selection_criterium = SelectionCriterium.new
    @classification_codes = ClassificationCode.all 
    @procurement_types = ProcurementType.all 
    @set_asides = SetAside.all 
  end

  # GET /selection_criteria/1/edit
  def edit
    @classification_codes = ClassificationCode.all
    @procurement_types = ProcurementType.all 
    @set_asides = SetAside.all 
    @set_aside_radios = SetAsideRadio.all
  end

  # POST /selection_criteria
  # POST /selection_criteria.json
  def create
    @selection_criterium = SelectionCriterium.new(selection_criterium_params)

    respond_to do |format|
      if @selection_criterium.save
        format.html { redirect_to @selection_criterium, notice: 'Selection criterium was successfully created.' }
        format.json { render action: 'show', status: :created, location: @selection_criterium }
      else
        format.html { render action: 'new' }
        format.json { render json: @selection_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /selection_criteria/1
  # PATCH/PUT /selection_criteria/1.json
  def update
    respond_to do |format|
      if @selection_criterium.update(selection_criterium_params)
        format.html { redirect_to team_path(@selection_criterium.team_id), notice: 'Selection criteria updated and will be applied to future opportunities.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @selection_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selection_criteria/1
  # DELETE /selection_criteria/1.json
  def destroy
    @selection_criterium.destroy
    respond_to do |format|
      format.html { redirect_to selection_criteria_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selection_criterium
      @selection_criterium = SelectionCriterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def selection_criterium_params
      #params.require(:selection_criterium).permit()
      params.require(:selection_criterium).permit(:name, :team_id, :set_aside_radio_id, :classification_code_ids => [], :procurement_type_ids => [], :set_aside_ids => [] )
    end
end
