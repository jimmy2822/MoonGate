class Gate < ApplicationRecord
    has_many :like_logs, dependent: :destroy
    belongs_to :user, foreign_key:"user_id"

    # mount CarrierWave uploader
    mount_uploader :icon, ImageUploader
    
    # Gate as taggable
    acts_as_taggable
end
