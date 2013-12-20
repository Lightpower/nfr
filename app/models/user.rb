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
                  :team_id, :avatar_url
  # Use login an username OR email
  attr_accessor :login
  attr_accessible :login

  # Validations
  validates_format_of :username, with: /^[\w\-_\.]{3,32}$/,                         if: Proc.new {|u| u.username.present? }
  validates_format_of :password, with: /^[\w\-_\.]{6,32}$/,                         if: Proc.new {|u| u.password.present? }
  validates_format_of :avatar_url, with: /^http(s?):\/\/[a-zA-Z0-9\-_\.\/]+$/,       if: Proc.new {|u| u.avatar_url.present? }


  # Scopes

  scope :by_username, order(:username)

  ##
  # Reload user authorization - use email OR username
  #
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
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
