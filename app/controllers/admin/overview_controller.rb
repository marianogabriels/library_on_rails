module Admin
  class OverviewController < Admin::ApplicationController
    def index
      @stats = {
        total_books: Book.count,
        borrowed_books: Borrow.waiting_return.count,
        borrowed_books_due_today: Borrow.due_today.count
      }
      @users_with_overdue_books = User.with_overdue_books
    end
  end
end
