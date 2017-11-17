class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope ->{ order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 },
                      presence: true

  def as_json(options = {})
    options[:except] ||= [:id]
    super(options)
  end
end
