class Gate < ApplicationRecord
    has_many :like_logs, dependent: :destroy
    belongs_to :user
end
