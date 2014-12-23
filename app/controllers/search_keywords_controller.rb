class SearchKeywordsController < ApplicationController
  before_action :set_search_keyword, only: [:show, :edit, :update, :destroy]

  # GET /search_keywords
  # GET /search_keywords.json
  def index
    @search_keywords = SearchKeyword.all
  end

  # GET /search_keywords/1
  # GET /search_keywords/1.json
  def show
  end

  # GET /search_keywords/new
  def new
    @search_keyword = SearchKeyword.new
  end

  # GET /search_keywords/1/edit
  def edit
  end

  # POST /search_keywords
  # POST /search_keywords.json
  def create
    @search_keyword = SearchKeyword.new(search_keyword_params)

    respond_to do |format|
      if @search_keyword.save
        format.html { redirect_to @search_keyword, notice: 'Search keyword was successfully created.' }
        format.json { render action: 'show', status: :created, location: @search_keyword }
      else
        format.html { render action: 'new' }
        format.json { render json: @search_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_keywords/1
  # PATCH/PUT /search_keywords/1.json
  def update
    respond_to do |format|
      if @search_keyword.update(search_keyword_params)
        format.html { redirect_to @search_keyword, notice: 'Search keyword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @search_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_keywords/1
  # DELETE /search_keywords/1.json
  def destroy
    @search_keyword.destroy
    respond_to do |format|
      format.html { redirect_to search_keywords_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_keyword
      @search_keyword = SearchKeyword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_keyword_params
      params.require(:search_keyword).permit(:team_id, :name)
    end
end
