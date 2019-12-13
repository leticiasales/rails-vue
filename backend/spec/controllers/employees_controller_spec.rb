require 'rails_helper'
RSpec.describe EmployeesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Employee. As you add validations to Employee, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:employee)
  }

  let(:invalid_attributes) {
    { 
      name: "a",
      salary: Faker::Number.decimal
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      position = create(:position)
      employee = create(:employee, position_id: position.id)
      @user = create(:user)
      request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
      
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      @user = create(:user)
      position = create(:position)
      employee = create(:employee, position_id: position.id)
      request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

      get :show, params: {id: employee.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Employee" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

        position = create(:position)
        valid_attributes[:position_id] = position.id

        puts valid_attributes

        expect {
          post :create, params: {employee: valid_attributes}
        }.to change(Employee, :count).by(1)
      end

      it "renders a JSON response with the new employee" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

        position = create(:position)
        valid_attributes[:position_id] = position.id

        post :create, params: {employee: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.location).to eq(employee_url(Employee.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new employee" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)

        position = create(:position)
        invalid_attributes[:position_id] = position.id

        post :create, params: {employee: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: Faker::Job.title }
      }

      it "updates the requested employee" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
        position = create(:position)
        employee = create(:employee, position_id: position.id)

        put :update, params: {id: employee.to_param, employee: new_attributes}
        employee.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the employee" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
        position = create(:position)
        employee = create(:employee, position_id: position.id)

        put :update, params: {id: employee.to_param, employee: valid_attributes}
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the employee" do
        @user = create(:user)
        request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
        position = create(:position)
        employee = create(:employee, position_id: position.id)

        invalid_attributes[:position_id] = position.id

        put :update, params: {id: employee.to_param, employee: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested employee" do
      @user = create(:user)
      request.headers['Authorization'] = ApplicationHelper.encode(user_id: @user.id)
      position = create(:position)
      employee = create(:employee, position_id: position.id)

      expect {
        delete :destroy, params: {id: employee.to_param}
      }.to change(Employee, :count).by(-1)
    end
  end

end
