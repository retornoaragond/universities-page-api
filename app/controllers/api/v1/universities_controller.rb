# frozen_string_literal: true

class API::V1::UniversitiesController < API::V1::APIController

  before_action :find_university, only: %i[show update destroy]

  def index
    universities = University.all
    render json: universities
  end

  def show
    render json: @university
  end

  def create
    university = University.new(university_params)
    if university.save
      render json: { message: "University created successfully", university: university }, status: :created
    else
      render json: { errors: university.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @university.update(university_params)
      render json: { message: "University updated successfully", university: @university }, status: :ok
    else
      render json: { errors: @university.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @university.destroy
    render status: :no_content
  end

  private

  def university_params
    params.require(:university).permit(
      :name, :location, :website_url,
      contact_emails_attributes: %i[id email _destroy]
    )
  end

  def find_university
    @university = University.find(params[:id])
  end

end
