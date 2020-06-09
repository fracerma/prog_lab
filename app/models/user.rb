class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # caratteristiche di ogni utente iscritto a WhereNext:
  # autenticabili attraverso l'uso del database (la loro identità digitale
  # verrà salvata dentro il database), i loro attributi potranno essere recuperati (:recoverable), 
  # l'utente potrà clicare su "ricordami" per non dover farel'autenticazione tutte le volte (:rememberable), etc..
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, 
         :omniauth_providers => [:facebook] 

    #has_secure_password
    validates :email, presence: true, uniqueness: true

    PASSWORD_REQUIREMENTS= /\A
        (?=.{8,}) # Almeno 8 caratteri
        (?=.*\d) # Almeno un numero
        (?=.*[A-Z]) # Almeno un carattere maiuscolo
        (?=.*[[:^alnum:]]) # Almeno un simbolo
    /x

    validates :password, presence: true, format:PASSWORD_REQUIREMENTS, :if => :password
    
    has_many :fav_locations
    has_many :locations, :through => :fav_locations, :dependent => :destroy

    has_many :fav_categories
    has_many :categories, :through => :fav_categories, :dependent => :destroy

    has_many :friendships  
    has_many :friends, :through => :friendships

    has_many :reviews

    has_many :groups
    has_many :gatherings, :through => :groups

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.name = auth.info.name   # assuming the user model has a name
            user.avatar = auth.info.image # assuming the user model has an image
            user.password = Devise.friendly_token[0,20]
        end
    end
    
    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
            user.email = data["email"] if user.email.blank?
            end
        end
    end 
    end
