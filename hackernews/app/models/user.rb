class User < ActiveRecord::Base
  has_many :comments
  has_many :posts
  has_many :postvotes
  has_many :commentvotes

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password_hash, presence: true

  def self.authenticate(username, password)
    @current_user = User.find_by_username(username)
    if @current_user && @current_user.password == password
      @current_user
    else
      nil
    end
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

end
