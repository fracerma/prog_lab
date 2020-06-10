Canard::Abilities.for(:User) do
  can [:read], Category
  cannot [:create, :destroy, :update], Category
  can [:read], Location
  cannot [:create, :destroy, :update], Location
  
end
