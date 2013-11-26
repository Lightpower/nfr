class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team
  has_many :teams # captain of team
  has_many :team_requests

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me,
                  :team, :team_id
  # Use login an username OR email
  attr_accessor :login
  attr_accessible :login

  ##
  # Reload user authorization - use email OR username
  #
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def is_admin?
    role == 'admin'
  end

  def waiting_for_approving?
    self.team_requests.present? && self.team.blank?
  end

  ##
  # Is user a captain of his team
  #
  def is_captain?
    self == self.team.try(:captain)
  end

  ##
  # User name (or email if username is empty)
  #
  def show_name
    username.present? ? username : email
  end

end
