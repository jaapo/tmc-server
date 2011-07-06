class User < ActiveRecord::Base
  validates :login, :presence     => true,
                    :confirmation => true,
                    :length       => { :within => 2..20 }

  attr_accessor :password
  validate :check_password
  before_save :encrypt_password

  def has_password?(submitted_password)
    password_hash == encrypt(submitted_password)
  end

  def self.authenticate(login, submitted_password)
    user = find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.password_hash = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
  def check_password
    errors[:password] << "password must be set" if new_record? && password.blank?
    if password != nil
      errors[:password] << "the password is too short" if password.length < 6
    end
  end
end