class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope ->{ order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 },
                      presence: true
  validate :picture_size

  def as_json(options = {})
    options[:except] ||= [:id]
    super(options)
  end

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5 MB")
    end
  end
end
