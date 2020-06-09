require 'rubygems'
require 'role_model'

class User < ApplicationRecord
  include RoleModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # caratteristiche di ogni utente iscritto a WhereNext:
  # autenticabili attraverso l'uso del database (la loro identità digitale
  # verrà salvata dentro il database), i loro attributi potranno essere recuperati (:recoverable), 
  # l'utente potrà clicare su "ricordami" per non dover farel'autenticazione tutte le volte (:rememberable), etc..
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
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


    roles :admin, :owner, :user

    acts_as_user :roles=> [:user, :owner, :admin]

end