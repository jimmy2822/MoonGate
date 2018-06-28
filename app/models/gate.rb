class Gate < ApplicationRecord
    has_many :like_logs, dependent: :destroy
    belongs_to :user, foreign_key:"user_id"
    
    # Gate as taggable
    acts_as_taggable
end
