class SetAsidesController < ApplicationController
  before_action :set_set_aside, only: [:show, :edit, :update, :destroy]

  # GET /set_asides
  # GET /set_asides.json
  def index
    @set_asides = SetAside.all
  end

  # GET /set_asides/1
  # GET /set_asides/1.json
  def show
  end

  # GET /set_asides/new
  def new
    @set_aside = SetAside.new
    @selection_criteria = SelectionCriterium.all
  end

  # GET /set_asides/1/edit
  def edit
    @selection_criteria = SelectionCriterium.all
  end

  # POST /set_asides
  # POST /set_asides.json
  def create
    @set_aside = SetAside.new(set_aside_params)

    respond_to do |format|
      if @set_aside.save
        format.html { redirect_to @set_aside, notice: 'Set aside was successfully created.' }
        format.json { render action: 'show', status: :created, location: @set_aside }
      else
        format.html { render action: 'new' }
        format.json { render json: @set_aside.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /set_asides/1
  # PATCH/PUT /set_asides/1.json
  def update
    respond_to do |format|
      if @set_aside.update(set_aside_params)
        format.html { redirect_to @set_aside, notice: 'Set aside was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @set_aside.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /set_asides/1
  # DELETE /set_asides/1.json
  def destroy
    @set_aside.destroy
    respond_to do |format|
      format.html { redirect_to set_asides_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_set_aside
      @set_aside = SetAside.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def set_aside_params
      params.require(:set_aside).permit(:name, :selection_criterium_ids => [])
    end
end
