require 'rails_helper'
RSpec.describe PositionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Position. As you add validations to Position, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: Faker::Job.title }
  }

  let(:invalid_attributes) {
    { name: "a" }
  }

  describe "GET #index" do
    it "returns a success response" do
      position = Position.create! valid_attributes
      @user = create(:user)
      request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
      
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      @user = create(:user)
      position = Position.create! valid_attributes
      request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

      get :show, params: {id: position.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Position" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

        expect {
          post :create, params: {position: valid_attributes}
        }.to change(Position, :count).by(1)
      end

      it "renders a JSON response with the new position" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

        post :create, params: {position: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.location).to eq(position_url(Position.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new position" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

        post :create, params: {position: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: Faker::Job.title }
      }

      it "updates the requested position" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
        position = Position.create! valid_attributes

        put :update, params: {id: position.to_param, position: new_attributes}
      end

      it "renders a JSON response with the position" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
        position = Position.create! valid_attributes

        put :update, params: {id: position.to_param, position: valid_attributes}
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the position" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
        position = Position.create! valid_attributes

        put :update, params: {id: position.to_param, position: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested position" do
      @user = create(:user)
      request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
      position = Position.create! valid_attributes

      expect {
        delete :destroy, params: {id: position.to_param}
      }.to change(Position, :count).by(-1)
    end
  end

end
