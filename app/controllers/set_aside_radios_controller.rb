class SetAsideRadiosController < ApplicationController
  before_action :set_set_aside_radio, only: [:show, :edit, :update, :destroy]

  # GET /set_aside_radios
  # GET /set_aside_radios.json
  def index
    @set_aside_radios = SetAsideRadio.all
  end

  # GET /set_aside_radios/1
  # GET /set_aside_radios/1.json
  def show
  end

  # GET /set_aside_radios/new
  def new
    @set_aside_radio = SetAsideRadio.new
  end

  # GET /set_aside_radios/1/edit
  def edit
  end

  # POST /set_aside_radios
  # POST /set_aside_radios.json
  def create
    @set_aside_radio = SetAsideRadio.new(set_aside_radio_params)

    respond_to do |format|
      if @set_aside_radio.save
        format.html { redirect_to @set_aside_radio, notice: 'Set aside radio was successfully created.' }
        format.json { render action: 'show', status: :created, location: @set_aside_radio }
      else
        format.html { render action: 'new' }
        format.json { render json: @set_aside_radio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /set_aside_radios/1
  # PATCH/PUT /set_aside_radios/1.json
  def update
    respond_to do |format|
      if @set_aside_radio.update(set_aside_radio_params)
        format.html { redirect_to @set_aside_radio, notice: 'Set aside radio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @set_aside_radio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /set_aside_radios/1
  # DELETE /set_aside_radios/1.json
  def destroy
    @set_aside_radio.destroy
    respond_to do |format|
      format.html { redirect_to set_aside_radios_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_set_aside_radio
      @set_aside_radio = SetAsideRadio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def set_aside_radio_params
      params.require(:set_aside_radio).permit(:name)
    end
end
