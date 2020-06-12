require 'rails_helper'

# render_template : delegates to assert_template
# redirect_to : delegates to assert_redirected_to

RSpec.describe "Categories management", type: :request do
    let(:user) { FactoryBot.create(:user) }
    let(:current_user) {user}

    it "creates a category and redirects to the Category's page" do
        
        get "/users/sign_in"
        expect(response).to render_template(:new)
    
        post "/categories", :params => { :category => {:name => "My Test Category"} }
    
        #expect(response).to redirect_to(assigns(:category))
        #follow_redirect!
    
        #expect(response).to render_template(:show)
        #expect(response.body).to include("My Test Category")
    end
    
      it "does not render a different template" do
        get "/categories/new"
        expect(response).to_not render_template(:show)
      end




end
