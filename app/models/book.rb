class Book < ApplicationRecord
	# モデルの関係づけ
	belongs_to :user
	# book_comment 1:n
	has_many :book_comments, dependent: :destroy
	# favorite 1:n
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

end
