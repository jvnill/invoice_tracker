class InvoicesController < ApplicationController
  before_action :set_user_as_current_user
  before_action :invoice_params, only: [:create, :update]

  load_and_authorize_resource through: :user

  before_action :set_invoice_item_quantity, only: %i[create update]

  def index
    @invoices = @invoices.includes(project: :client).ordered_by_id
  end

  def new
    @invoice.invoice_items.build
  end

  def create
    @invoice.save
  end

  def show
    @project       = @invoice.project
    @client        = @project.client
    @invoice_items = @invoice.invoice_items.ordered_by_id
  end

  def update
    @invoice.update_attributes(invoice_params)
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path
  end

  def download
    render pdf: @invoice.number.to_s,
           disposition: 'attachment',
           page_size: @invoice.page_size,
           dpi: 300,
           margin: { top: 0, bottom: 0, left: 0, right: 0 },
           show_as_html: params[:preview]
  end

  def cycle_status
    @invoice.update_column :status, @invoice.next_status

    render json: { status: @invoice.status.titleize }
  end

  private

  def invoice_params
    params[:invoice] = params.require(:invoice).permit(:project_id, :number, :date, :client_reference_number, :due_date, :payment_details, :currency, :page_size, :no_quantity, invoice_items_attributes: [:name, :quantity, :unit_amount, :id, :_destroy])
  end

  def set_invoice_item_quantity
    return unless @invoice.no_quantity?

    @invoice.invoice_items.each { |invoice_item| invoice_item.quantity = 1 }
  end
end
