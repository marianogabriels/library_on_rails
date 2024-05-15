class Api::V1::BooksController < Api::V1::ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /api/v1/books
  def index
    books = Book.all
    render json: books, status: :ok
  end

  # GET /api/v1/books/:id
  def show
    render json: @book, status: :ok
  end

  # POST /api/v1/books
  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: {errors: book.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/books/:id
  def update
    if @book.update(book_params)
      render json: @book, status: :ok
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/books/:id
  def destroy
    @book.destroy
    head :no_content
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies)
  end
end
