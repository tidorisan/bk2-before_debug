class BookCommentsController < ApplicationController
	def create
		# データを受け取ってsaveする commentはフォームから受け取る user_idとbook_idが欲しい
		# urlに:id含まれてないので:id使えない
		# リダイレクトで必要 @bookにいれるためにbook.findmの形
		# このアクションへのurlにbook_idと記載されているので:idでは無くbook_idを用いる
		# book_comment controlerだが別に他のモデルを使うこともできる
		@book = Book.find(params[:book_id])
		# コメントを受け取る
		@book_newbook = BookComment.new(book_comment_params)
		# user_id
		@book_newbook.user_id = current_user.id
		# showページなのえid 一つ持ってきている
		@book_newbook.book_id = @book.id
		# error
		if @book_newbook.save
				redirect_to request.referer
		else
				# book showページ表示のためのインスタンス変数
				#  bookd/showページでエラーを表示されるためにエラーを受けった値そのまま持っていく
    			# @book = Book.find(params[:id])
    			# user info
    			@user = @book.user
    			# new book からのオブジェクトが欲しい
    			@book_newbook = Book.new
    			# book_coment のフォーム
    			# @book_comment_new = BookComment.new
    			#  book commentの一覧 index
    			@book_comments = @book.book_comments.all
    			# レンダーメソッド フォルダの階層を書くので被災間違え注意する
				render "books/show"
		end
	end

	def destroy
		#データ取得してdestry　destroy正常に動く
		# リダイレクト先へのインスタンス変数
		@book = Book.find(params[:book_id])
		# モデルが正確に取ってくるように指定する
		book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
		book_comment.destroy
		redirect_to book_path(@book)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
