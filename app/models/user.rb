class User < ActiveRecord::Base
  before_save {self.email = email.downcase.gsub(/\s+/, "")}
  
  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.gsub(/\s+/, ""))
    if user && user.authenticate(password)
      user
    end
  end
end
