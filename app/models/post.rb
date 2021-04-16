class Post < ApplicationRecord
  belongs_to :user
  has_many :articles, -> { order("done ASC, position ASC").includes(:post) }, dependent: :destroy

 validates :title, presence: true
end
