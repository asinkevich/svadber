class ExpendituresController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  respond_to :json

  def index
    respond_with expenditures
  end

  def show
    respond_with expenditures.find_by_id(params[:id])
  end

  def create
    respond_with expenditures.create
  end

  def update
    find_expenditure {|expenditure| expenditure.update_attributes(expenditure_params)}
  end

  def destroy
    find_expenditure {|expenditure| expenditure.destroy}
  end

  private

  def expenditures
    current_user.wedding.expenditures
  end

  def find_expenditure
    expenditure = expenditures.find_by_id(params[:id])
    if expenditure
      yield expenditure
    end
    render nothing: true
  end

  def expenditure_params
    params.require(:expenditure).permit(:cost, :paid, :description)
  end
end