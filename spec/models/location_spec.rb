require 'rails_helper'

RSpec.describe Location, type: :model do
  before(:each) { @l = Location.new(:name=> "TestLocation",
       :street=> "Via Test",
       :long=> 1,
       :lat=> 4,
       :status=>"pending")}
  
  it "is a valid location" do 
    expect( @l.name ).to eq( "TestLocation")
    expect( @l.street ).to eq( "Via Test")
    expect( @l.long ).to eq( 1 )
    expect( @l.lat ).to eq( 4)
    expect( @l.status ).to eq( "pending")
  end
end
