class Category < ApplicationRecord
    has_many :types
    has_many :locations, :through => :types,  :dependent => :destroy
end

#types è la tabella join location-category