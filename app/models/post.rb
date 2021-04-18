class Post < ApplicationRecord
  belongs_to :user
 validates :title, presence: true
 enum status: { private: 0, public: 1 }, _prefix: true
end
