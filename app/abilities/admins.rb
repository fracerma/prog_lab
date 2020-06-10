Canard::Abilities.for(:admin) do
  can [:create, :read, :update, :destroy], Category
  
  can [:create, :read, :update, :destroy], Location
  can [:create, :update, :show, :destroy], Gathering
  can [:create, :read, :update, :destroy], Location
  
  
end
