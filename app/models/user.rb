class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true

    PASSWORD_REQUIREMENTS= /\A
        (?=.{8,}) # Almeno 8 caratteri
        (?=.*\d) # Almeno un numero
        (?=.*[A-Z]) # Almeno un carattere maiuscolo
        (?=.*[[:^alnum:]]) # Almeno un simbolo
    /x
    validates :password, presence: true, format:PASSWORD_REQUIREMENTS
    
    has_many :favourites, class_name: :Location
    has_many :friends, class_name: :User

    has_many :reviews
#   has_many :gatherings
