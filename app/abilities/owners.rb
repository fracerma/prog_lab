Canard::Abilities.for(:owner) do
  can [:read], Category
  cannot [:create,:delete,:update], Category
  can [:create, :read, :update, :destroy], Location
end
