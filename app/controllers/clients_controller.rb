class ClientsController < ApplicationController
  before_filter :set_user_as_current_user
  before_filter :client_params, only: [:create, :update]

  load_and_authorize_resource through: :user

  def create
    @client.save
  end

  def update
    @client.update_attributes(client_params)
  end

  def destroy
    @client.destroy
  end

  private

  def client_params
    params[:client] = params.require(:client).permit(:name, :contact_person, :address, :contact_number)
  end
end
