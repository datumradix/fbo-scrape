class SolicitationNumbersController < ApplicationController
  before_action :set_solicitation_number, only: [:show, :edit, :update, :destroy]

  # GET /solicitation_numbers
  # GET /solicitation_numbers.json
  def index
    @solicitation_numbers = SolicitationNumber.all
  end

  # GET /solicitation_numbers/1
  # GET /solicitation_numbers/1.json
  def show
  end

  # GET /solicitation_numbers/new
  def new
    @solicitation_number = SolicitationNumber.new
  end

  # GET /solicitation_numbers/1/edit
  def edit
  end

  # POST /solicitation_numbers
  # POST /solicitation_numbers.json
  def create
    @solicitation_number = SolicitationNumber.new(solicitation_number_params)

    respond_to do |format|
      if @solicitation_number.save
        format.html { redirect_to @solicitation_number, notice: 'Solicitation number was successfully created.' }
        format.json { render action: 'show', status: :created, location: @solicitation_number }
      else
        format.html { render action: 'new' }
        format.json { render json: @solicitation_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solicitation_numbers/1
  # PATCH/PUT /solicitation_numbers/1.json
  def update
    respond_to do |format|
      if @solicitation_number.update(solicitation_number_params)
        format.html { redirect_to @solicitation_number, notice: 'Solicitation number was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @solicitation_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solicitation_numbers/1
  # DELETE /solicitation_numbers/1.json
  def destroy
    @solicitation_number.destroy
    respond_to do |format|
      format.html { redirect_to solicitation_numbers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solicitation_number
      @solicitation_number = SolicitationNumber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solicitation_number_params
      params.require(:solicitation_number).permit(:name)
    end
end
