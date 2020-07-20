class FavoritesController < ApplicationController
	# いいね機能のアクション作る
	def create
		# 値を受けとって変数の中にいれる savaしてリダイレクトする
		# user_id を取得
		# 別にviewhに変数を持っていかないのでローカル変数用いる
		@book = Book.find(params[:book_id])

		@favorite = Favorite.new
		# user_id
		@favorite.user_id = current_user.id
		# book_id を習得する
		@favorite.book_id = @book.id

		if @favorite.save
				redirect_to request.referer

		end
	end

	def destroy
		# 値受け取って destroy リダイレクト
		@book = Book.find(params[:book_id])
		# ただのidだけだと指定出来ない book_
		favorite = Favorite.find_by(params[:book_id])
		favorite.user_id = @book.user_id
		favorite.destroy
		redirect_to request.referer
		# なぜかうまくいかなかった r理由聞く
		# @book = Book.find(params[:book_id])
		# # カリキュラムみて作成した 持ってくるidを指定するために[id]と　[book_id]を使っt指定する
		# favorite = Favorite.find_by(id: params[:id]], book_id: params[:book_id])
		# favorite.destroy
		# redirect_to request.referer

	end

	# 今回 ストロングパラメータ使用しない
end
