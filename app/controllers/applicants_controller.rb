class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])

    if params[:search].present?
      @pet_find = Pet.search(params[:search])
      
      # @pet_find = @pet_find.search_pet
    end
  end

  def new
    # @applicant = Applicant.find(params[:id])
  end

  def create
    applicant = Applicant.new(app_params)

    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      redirect_to "/applicants/new"
      flash[:alert] = "Please see examples and enter a valid response with no empty fields"
    end
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :qualification, :application_status)
  end
end