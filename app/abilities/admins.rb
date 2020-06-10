Canard::Abilities.for(:admin) do
  can [:create, :read, :update, :destroy], Category
  
  can [:create, :read, :update, :destroy], Location
  
  can [:create, :read, :update, :destroy], Review

  can [:create, :read, :update, :destroy], Gathering
  
end
