class Api::V1::BorrowsController < Api::V1::ApplicationController
  before_action :set_borrow, only: [:show, :destroy, :mark_as_returned]

  # GET /api/v1/borrows
  def index
    borrows = Borrow.all
    render json: borrows, status: :ok
  end

  # GET /api/v1/borrows/:id
  def show
    render json: @borrow, status: :ok
  end

  # POST /api/v1/borrows
  def create
    borrow = Borrow.new(borrow_params)
    if borrow.save
      render json: borrow, status: :created
    else
      render json: borrow.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/borrows/:id/mark_as_returned
  def mark_as_returned
    if @borrow.update(returned_at: Time.current)
      render json: @borrow, status: :ok
    else
      render json: @borrow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/borrows/:id
  def destroy
    @borrow.destroy
    head :no_content
  end

  private

  def set_borrow
    @borrow = Borrow.find(params[:id])
  end

  def borrow_params
    params.require(:borrow).permit(:user_id, :book_id, :due_at, :returned_at)
  end
end
