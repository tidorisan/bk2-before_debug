class BooksController < ApplicationController

  def show
    # book show
    @book = Book.find(params[:id])
    # user info
    @user = @book.user
    # new book からのオブジェクトが欲しい
    @book_newbook = Book.new
  end

  def index
    # user info はvireで生成している
    #books index
    @books = Book.all
    # new book
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    # 注意
    book.user_id = current_user.id
    if book.save
      redirect_to book_path(book.id), notice: "You have created book successfully."
    else
      #books index
      @books = Book.all
      # new book
      @book = Book.new
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

end
