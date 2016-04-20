class RatingsController < ApplicationController

  NOTICE_CREATE_SUCCESS = 'Rating was successfully created. '\
                          'It will be available soon'
  NOTICE_UPDATE_SUCCESS = 'Rating was successfully updated. '\
                          'It will be available soon'
  NOTICE_DESTROY_SUCCESS = 'Rating was successfully destroyed.'

  before_action :authenticate_customer!, except: [:index, :show]
  # before_action :authenticate_customer_if_exists, only: [:index]
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  
  skip_load_resource only: [:index, :new]
  load_and_authorize_resource

  # GET /ratings/new
  def new
    @book = Book.find(params[:book_id])
    @rating = Rating.new(book: @book, customer: current_customer)
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @book = Book.find(params[:book_id])
    @rating = Rating.new(rating_params)
    @rating.customer = current_customer

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rating, notice: NOTICE_CREATE_SUCCESS }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:id, :rate, :review, :book_id)
    end
end
