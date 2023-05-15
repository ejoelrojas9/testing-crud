require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:store) { create(:store) }

  describe 'GET #index' do  # Modulo y descripción del test en este caso Index
    it "renders the index template" do  # Inicio individual del test
      get :index  # Acción o metodo del controlador que se va a testear
      # Función que compara el resultado que se espera recibir
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do  # Inicio del modulo de prueba para el metodo Show
    let(:params) do  # Variable local de los parametros que recibe el test
      { 
        id: store.id
      }
    end
    it "render the show templae" do  # Inicio individual del test
      get :show, params: params  # Asignación del metodo y parametros
      # Función que compara el resultado que se espera recibir
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do # Inicio del modulo de prueba para el metodo New
    it "render the new template" do # Inicio individual del test
      get :new  # Asignación del metodo
      # Función que compara el resultado que se espera recibir
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do # Inicio del modulo de prueba para el metodo Create
    let(:params) do # Variable local de los parametros que recibe el test
      { 
        store: {
          # Datos aleatorios locales para el modulo
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
    it "create the new store and render the show view" do # Inicio individual del test
      post :create, params: params # Asignación del metodo y parametros
      store = Store.last  # Asignación del objeto creado en el test
      # Comparación de un dato, el del objeto creado y el que viene en el parametro
      expect(store.article).to eq(params[:store][:article])
      expect(store.state).to eq(params[:store][:state])
      # Comparación del redireccionamiento una vez creado el objeto
      expect(response).to redirect_to("/stores/#{store.id}")
    end
  end

  describe 'GET #edit' do # Inicio del modulo de prueba para el metodo Edit
    let(:params) do # Variable local de los parametros que recibe el test
      { 
        id: store.id
      }
    end
    it "render the store form" do # Inicio individual del test
      get :edit, params: params # Asignación del metodo y parametros
      # Función que compara el resultado que se espera recibir
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do  # Inicio del modulo de prueba para el metodo Update
    let(:params) do # Variable local de los parametros que recibe el test
    { 
      id: store.id,
      store: {
        # Datos aleatorios locales para el modulo
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
    it "update the store and render the template show store" do # Inicio individual del test
      put :update, params: params # Asignación del metodo y parametros
      # Comparación de un dato, el del objeto creado y el que viene en el parametro
      # En este caso store.reload evita recibir datos de otro modulo de prueba
      expect(store.reload.article).to eq(params[:store][:article])
      expect(store.reload.in_warehouse).to eq(params[:store][:in_warehouse])
      # Comparación del redireccionamiento una vez actualizado el objeto
      expect(response).to redirect_to("/stores/#{store.id}")
    end
  end

  describe 'DELETE #destroy' do # Inicio del modulo de prueba para el metodo Destroy
    let(:params) do # Variable local de los parametros que recibe el test
      {  
        id: store.id
      }
    end
    it "render template index" do # Inicio individual del test
      delete :destroy, params: params # Asignación del metodo y parametros
      # Comparación del redireccionamiento una vez eliminado el objeto
      expect(response).to redirect_to(stores_path)
    end
  end

end