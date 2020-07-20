class BookComment < ApplicationRecord
	# user 1:n
	belongs_to :user
	# book 1:n
	belongs_to :book
	# バリデーションチェック
	validates :comment, presence: true
end
