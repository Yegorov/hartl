class User < ActiveRecord::Base
  before_save { email.downcase! }
  has_many :microposts
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: /\A[A-Za-z0-9\.+\-\_]+@([A-Za-z]+\.?)+[^\.\_]\z/ },
                                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password

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

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
           BCrypt::Engine::MIN_COST :
           BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
