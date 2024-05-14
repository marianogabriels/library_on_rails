class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def borrow
    @book = Book.find(params[:id])
    @borrow = Borrow.new(user: current_user, book: @book)

    if @borrow.save
      redirect_to books_path, notice: 'Book was successfully borrowed.'
    else
      redirect_to books_path, alert: 'Unable to borrow the book.'
    end
  end
end
