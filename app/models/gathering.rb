class Gathering < ApplicationRecord
    belongs_to :location
    
    has_many :groups
    has_many :users, :through => :groups


    # metodo di prova per aggiungere una lista di utenti a un gruppo per questa uscita
    def new_group(utenti)
        utenti.each do |n|
            self.users << n
            #magari qui possiamo aggiunger che manda una notifica ad ognuno di questi
        end
    end
end
