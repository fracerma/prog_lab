class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true

    PASSWORD_REQUIREMENTS= /\A
        (?=.{8,}) # Almeno 8 caratteri
        (?=.*\d) # Almeno un numero
        (?=.*[A-Z]) # Almeno un carattere maiuscolo
        (?=.*[[:^alnum:]]) # Almeno un simbolo
    /x

    validates :password, presence: true, format:PASSWORD_REQUIREMENTS, :if => :password
    
    has_many :fav_locations
    has_many :locations, :through => :fav_locations

    has_many :friendships  
    has_many :friends, :through => :friendships

    has_many :reviews

    has_many :groups
    has_many :gatherings, :through => :groups
end