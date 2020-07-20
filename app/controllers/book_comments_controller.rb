class BookCommentsController < ApplicationController
	def create
		# データを受け取ってsaveする commentはフォームから受け取る user_idとbook_idが欲しい
		# urlに:id含まれてないので:id使えない
		# リダイレクトで必要 @bookにいれるためにbook.findmの形
		# このアクションへのurlにbook_idと記載されているので:idでは無くbook_idを用いる
		# book_comment controlerだが別に他のモデルを使うこともできる
		@book = Book.find(params[:book_id])
		# コメントを受け取る
		@book_comment = BookComment.new(book_comment_params)
		# user_id
		@book_comment.user_id = current_user.id
		# showページなのえid 一つ持ってきている
		@book_comment.book_id = @book.id
		# error
		if @book_comment.save
				redirect_to request.referer
		else
				render "book/show"
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
