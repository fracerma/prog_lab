require 'rails_helper.rb'

describe LocationsController do
	describe "GET locations#accept" do
		context "when the user is an admin" do
			it "shows the pending locations" do
				#admin = create(:user)
				location = create(:location)
				get :accept
				expect(location.status).to eq ("pending")
			end
		end
	end
	#describe ".accept_location" do
	#	context "I click on confirm" do
	#		it "accepts the locations" do
	#			#location = create(:location)
	#			post :accept_location, params: {accepted: location.id}
	#			expect(location.status).to eq ("accepted")
	#		end
	#	end
	#end
end

# describe "GET stories#index" do
#   context "when the user is an admin" do
#     it "should list titles of all stories" do
#       admin = create(:admin)
#       stories = create_list(:story, 10, user: admin)
#       login_as(admin, scope: :user)
#       visit stories_path
#       stories.each do |story|
#         page.should have_content(story.title)
#       end
#     end
#   end
#   context "when the user is not an admin" do
#     it "should list titles of users own stories" do
#       user = create(:user)
#       stories = create_list(:story, 10, user: user)
#       login_as(user, scope: :user)
#       visit stories_path
#       stories.each do |story|
#         page.should have_content(story.title)
#       end
#     end
#   end
# end