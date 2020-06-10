Canard::Abilities.for(:user) do
  can [:read], Category
  cannot [:create, :destroy, :update], Category
  can [:read], Location
  cannot [:create, :destroy, :update], Location
  #can [:create, :destroy, :update, :read], FavCategory
end
