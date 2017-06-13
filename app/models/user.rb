class User < ActiveRecord::Base

  # before_create do |user|
  #   user[:password] = user[:password].downcase
  #   user[:password_confirmation] = user[:password_confirmation].downcase
  # end

  has_secure_password

  has_many :reviews

  validates_uniqueness_of :email, case_sensitive: false

  validates_presence_of :email, :first_name, :last_name, :password_confirmation

  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)

    user = User.where("lower(email) = ?", email.downcase).first
    # if the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
