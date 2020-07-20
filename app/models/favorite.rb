class Favorite < ApplicationRecord
	# user
	belongs_to :user
	# book
	belongs_to :book
	# バリデーションチェック　いいね機能　１つの投稿につき１回のいいね
	validates_uniqueness_of :book_id, scope: :user_id
end
