class Post < ApplicationRecord
  belongs_to :user
 validates :title, presence: true
 enum status: { private: 0, public: 1 }, _prefix: true
  belongs_to :prefecture, optional: true
   mount_uploader :picture, PictureUploader
end
