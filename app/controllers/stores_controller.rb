class StoresController < ApplicationController

  def index
    @stores = Store.all.order(id: :asc)
  end

  def show
    set_store
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new store_params
    respond_to do |format|
      if @store.save
        @store = Store.last
        format.html { redirect_to store_path(@store.id), notice: "Store Created", remote: false }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    set_store
  end

  def update
    if set_store.update(store_params)
      redirect_to store_path, notice: "Store Update"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_store
    if set_store.destroy
      redirect_to stores_path, alert: "Store deleted"
    else
      redirect_to store_path, alert: "Store not deleted"
    end
  end

  private

  def set_store
    @store = Store.find params[:id]
  end

  def store_params
    params.require(:store).permit!
  end

end
