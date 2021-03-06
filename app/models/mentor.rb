class Mentor < ActiveRecord::Base
  acts_as_messageable
before_save { self.email = email.downcase }
   before_create :create_remember_token
   validates :fname, presence: true, length: { maximum: 20 }
   #validates :expertise, presence: true
   validates :mentor_interest, presence: true
   #VALID_INTEGER =/\d +\d/
   #validates :time_devoted_monthly, presence: true , format: { with: VALID_INTEGER}
   validates :lname, presence: true, length: { maximum: 20 }
   acts_as_follower
   acts_as_followable
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
   has_secure_password
   validates :password, length: { minimum: 6 },:confirmation => true, 
                            :if       => :password_changed?
   has_attached_file :pic, :styles => 
          { :medium => "300x300>", :thumb => "100x100>" }

   def mailboxer_email(object)
    email
   end
   
   def Mentor.new_remember_token
    SecureRandom.urlsafe_base64
   end

   def Mentor.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
   end

   def password_changed?
    !@password.blank?
   end

  private

   def create_remember_token
     self.remember_token = Mentor.encrypt(Mentor.new_remember_token)
   end
end


