class User < ActiveRecord::Base
  has_many :microposts
  validates :name, presence: true
  validates :email, presence: true


  def posts
    microposts.limit(1)
  end

  def as_json(options={})
    options[:except] ||= [:id]
    options[:methods] ||= [:posts]
    h = super(options)
    h[:microposts] = h[:posts.to_s]
    h
  end
end
