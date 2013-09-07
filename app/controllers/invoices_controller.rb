class InvoicesController < ApplicationController
  before_filter :set_user_as_current_user
  before_filter :invoice_params, only: [:create, :update]

  load_and_authorize_resource through: :user

  def new
    @invoice.invoice_items.build
  end

  def create
    @invoice.save
  end

  def update
    @invoice.update_attributes(invoice_params)
  end

  def destroy
    @invoice.destroy
  end

  def download
  end

  private

  def invoice_params
    params[:invoice] = params.require(:invoice).permit(:project_id, :number, :date, :client_reference_number, :due_date, invoice_items_attributes: [:name, :quantity, :unit_amount, :id])
  end
end
