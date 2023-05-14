require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:store) { create(:store) }

  describe 'GET #index' do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index) 
    end
  end

  describe 'GET #show' do
    let(:params) do
      { 
        id: store.id
      }
    end
    it "render the show templae" do
      get :show, params: params
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it "render the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:params) do
      { 
        store: {
          article: Faker::Device.model_name,
          state: %w(New Uses Damaged Repaired).sample,
          in_warehouse: Faker::Number.between(from: 1, to: 100),
          on_counter: Faker::Number.between(from: 1, to: 5),
          price: Faker::Number.between(from: 500, to: 2000),
          created_at: "2023-05-14 12:27:14 UTC",
          updated_at: "2023-05-14 14:07:14 UTC"
        }
      } 
    end
    it "create the new store and render the show view" do
      post :create, params: params
      store = Store.last
      expect(store.article).to eq(params[:store][:article])
      expect(store.state).to eq(params[:store][:state])
      expect(response).to redirect_to("/stores/#{store.id}")
    end
  end

  describe 'GET #edit' do
    let(:params) do 
      { 
        id: store.id
      }
    end
    it "render the store form" do
      get :edit, params: params
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    let(:params) do
    { 
      id: store.id,
      store: {
        article: Faker::Device.model_name,
        state: %w(New Uses Damaged Repaired).sample,
        in_warehouse: Faker::Number.between(from: 1, to: 100),
        on_counter: Faker::Number.between(from: 1, to: 5),
        price: Faker::Number.between(from: 500, to: 2000),
        created_at: "2023-05-14 12:27:14 UTC",
        updated_at: "2023-05-14 14:07:14 UTC"
      }
    }
    end
    it "update the store and render the template show store" do
      put :update, params: params
      expect(store.reload.article).to eq(params[:store][:article])
      expect(store.reload.in_warehouse).to eq(params[:store][:in_warehouse])
      expect(response).to redirect_to("/stores/#{store.id}")
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      {  
        id: store.id
      }
    end
    it "render template index" do
      delete :destroy, params: params
      expect(response).to redirect_to(stores_path)
    end
  end
  
end
