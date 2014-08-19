class ClassificationCodesController < ApplicationController
  before_action :set_classification_code, only: [:show, :edit, :update, :destroy]
  filter_resource_access

  # GET /classification_codes
  # GET /classification_codes.json
  def index
    @classification_codes = ClassificationCode.all
  end

  # GET /classification_codes/1
  # GET /classification_codes/1.json
  def show
  end

  # GET /classification_codes/new
  def new
    @classification_code = ClassificationCode.new
    @selection_criteria = SelectionCriterium.all
  end

  # GET /classification_codes/1/edit
  def edit
    @selection_criteria = SelectionCriterium.all
  end

  # POST /classification_codes
  # POST /classification_codes.json
  def create
    @classification_code = ClassificationCode.new(classification_code_params)

    respond_to do |format|
      if @classification_code.save
        format.html { redirect_to @classification_code, notice: 'Classification code was successfully created.' }
        format.json { render action: 'show', status: :created, location: @classification_code }
      else
        format.html { render action: 'new' }
        format.json { render json: @classification_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classification_codes/1
  # PATCH/PUT /classification_codes/1.json
  def update
    respond_to do |format|
      if @classification_code.update(classification_code_params)
        format.html { redirect_to @classification_code, notice: 'Classification code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @classification_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classification_codes/1
  # DELETE /classification_codes/1.json
  def destroy
    @classification_code.destroy
    respond_to do |format|
      format.html { redirect_to classification_codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classification_code
      @classification_code = ClassificationCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classification_code_params
      params.require(:classification_code).permit(:name, :selection_criterium_ids => [])
    end
end
