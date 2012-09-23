class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :provider, :identity, :name
  has_secure_password
  validates_presence_of :password, :on => :create
  has_many :messages
  has_many :received_messages, :class_name => "Message", :foreign_key => "recipient_id"

  def self.process_via_loginza(token)
  	data = Loginza.verify(token)
  	return nil if data["error_type"]
  	u = User.where("provider = '#{data["provider"]}' and identity = '#{data["identity"]}'").first
  	User.create(provider:data["provider"], 
  		        identity:data["identity"], 
  		        name:"#{data["name"]["first_name"]} #{data["name"]["last_name"]}"
  		        ) unless u
  end

  def self.process_via_form(params)
  	user = User.find_by_email(params[:email])
	(user && user.authenticate(params[:password])) ? user : nil
  end

  def self.try_to_authenticate(params)
  	params[:token] ? User.process_via_loginza(params[:token]) : User.process_via_form({login:params[:login],password:params[:password]})
  end

end
