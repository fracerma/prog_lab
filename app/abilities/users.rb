Canard::Abilities.for(:User) do
  can [:read, :create_fav_categories], Category
  cannot [:create, :destroy, :update], Category
  can [:read], Location
  cannot [:create, :destroy, :update], Location
  
end
