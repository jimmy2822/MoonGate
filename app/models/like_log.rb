class LikeLog < ApplicationRecord
    belongs_to :gate
    belongs_to :user, foreign_key: 'who_liked'

    scope :by, ->(user) { where(user: user) }
end