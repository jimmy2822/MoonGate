class LikeLog < ApplicationRecord
    belongs_to :gate
    # validates :ip_address, uniqueness: true

end
