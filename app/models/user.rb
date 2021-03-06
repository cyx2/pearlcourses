# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string
#  numratings             :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :ratings, dependent: :destroy
  has_many :cornell_classes, :through => :ratings

  # Validator requires these fields for a user.
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true  
  validates :password, presence: true

  def self.countRatings
    User.find_each do |u|
      nR = u.ratings

      u.numratings = nR.where(user_id: u.id)
      u.save
    end
  end

end
