class Location < ApplicationRecord
    has_and_belongs_to_many :categories
    
    validates_presence_of :name
    validates_numericality_of :lat
    validates_numericality_of :long
end
