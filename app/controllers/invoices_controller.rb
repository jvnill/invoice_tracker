class InvoicesController < ApplicationController
  before_filter :set_user_as_current_user
  before_filter :invoice_params, only: [:create, :update]

  load_and_authorize_resource through: :user

  def index
    @invoices = @invoices.includes(project: :client)
  end

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
    render pdf: @invoice.number.to_s,
           disposition: 'attachment',
           page_size: @invoice.page_size,
           dpi: 300,
           margin: { top: 0, bottom: 0, left: 0, right: 0 },
           show_as_html: params[:preview]
  end

  def mark_as_sent
    @invoice.update_column :status, 'sent'
  end

  def mark_as_paid
    @invoice.update_column :status, 'paid'
  end

  private

  def invoice_params
    params[:invoice] = params.require(:invoice).permit(:project_id, :number, :date, :client_reference_number, :due_date, :payment_details, :currency, :page_size, :no_quantity, invoice_items_attributes: [:name, :quantity, :unit_amount, :id, :_destroy])
  end
end
