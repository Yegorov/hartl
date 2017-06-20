class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, length: { maximum: 140 },
                      presence: true

  def as_json(options = {})
    options[:except] ||= [:id]
    super(options)
  end
end
