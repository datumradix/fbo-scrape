class ProcurementTypesController < ApplicationController
  before_action :set_procurement_type, only: [:show, :edit, :update, :destroy]

  # GET /procurement_types
  # GET /procurement_types.json
  def index
    @procurement_types = ProcurementType.all
  end

  # GET /procurement_types/1
  # GET /procurement_types/1.json
  def show
  end

  # GET /procurement_types/new
  def new
    @procurement_type = ProcurementType.new
    @selection_criteria = SelectionCriterium.all
  end

  # GET /procurement_types/1/edit
  def edit
    @selection_criteria = SelectionCriterium.all
  end

  # POST /procurement_types
  # POST /procurement_types.json
  def create
    @procurement_type = ProcurementType.new(procurement_type_params)

    respond_to do |format|
      if @procurement_type.save
        format.html { redirect_to @procurement_type, notice: 'Procurement type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @procurement_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @procurement_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procurement_types/1
  # PATCH/PUT /procurement_types/1.json
  def update
    respond_to do |format|
      if @procurement_type.update(procurement_type_params)
        format.html { redirect_to @procurement_type, notice: 'Procurement type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @procurement_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procurement_types/1
  # DELETE /procurement_types/1.json
  def destroy
    @procurement_type.destroy
    respond_to do |format|
      format.html { redirect_to procurement_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procurement_type
      @procurement_type = ProcurementType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procurement_type_params
      params.require(:procurement_type).permit(:name, :selection_criterium_ids => [])
    end
end
