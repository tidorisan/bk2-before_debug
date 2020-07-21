class BooksController < ApplicationController
  # booksでの表示も全てログインしている状態のみに制限する
  before_action :authenticate_user!

  def show
    # book show
    @book = Book.find(params[:id])
    # user info
    @user = @book.user
    # new book からのオブジェクトが欲しい
    @book_newbook = Book.new
    # book_coment のフォーム
    @book_comment_new = BookComment.new
    # book commentの一覧 index
    @book_comments = @book.book_comments.all
  end

  def index
    # user info はvireで生成している
    #books index
    @books = Book.all
    # new book
    @book = Book.new
    # user = current_user 効果ないので元に戻す

  end

  def create
    @book = Book.new(book_params)
    # 注意
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      #books index
      @books = Book.all
      # new book
      # @book = Book.new
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
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
    params.require(:book).permit(:title, :body)
  end

end
