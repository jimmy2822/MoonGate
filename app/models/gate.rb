class Gate < ApplicationRecord
    has_many :like_logs, dependent: :destroy
    belongs_to :user, foreign_key:"user_id"

    # validation
    validates_presence_of(:name, :server)


    # mount CarrierWave uploader
    mount_uploader :icon, ImageUploader

    # Valid icon size < 500 kb
    validates_processing_of :icon
    validate :image_size_validation
 
    
    # Gate as taggable
    acts_as_taggable

    scope :public_server, -> { where( is_public:true )}

    private
    def image_size_validation
        errors[:icon] << "檔案必須小於於 1 MB !" if icon.size >= 1.megabytes
    end

end
