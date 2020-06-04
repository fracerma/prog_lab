class Location < ApplicationRecord
    has_many :types
    has_many :categories, :through => :types,  :dependent => :destroy
    
    has_many :reviews

    validates_presence_of :name
    validates_presence_of :street
    validates_numericality_of :lat
    validates_numericality_of :long
    
end
