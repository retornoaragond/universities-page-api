# frozen_string_literal: true

class API::V1::UniversitiesController < API::V1::APIController

  include Pagy::Backend

  before_action :find_university, only: %i[show update destroy]

  def index
    searchable_columns = %w[name] # Define the columns that can be searched: name, location or website_url

    scoped_universities = SearchAndSortService.new(University.all, params, searchable_columns).call

    @pagy, @universities = pagy(scoped_universities, items: params[:per_page] || 10)

    render json: {
      universities: ActiveModelSerializers::SerializableResource.new(@universities,
                                                                     each_serializer: UniversitySerializer),
      meta: pagy_metadata(@pagy),
    }, status: :ok
  end

  def show
    render json: @university, status: :ok, serializer: UniversitySerializer
  end

  def create
    university = University.new(university_params)
    if university.save
      render json: {
        message: "University created successfully",
        university: UniversitySerializer.new(university),
      }, status: :created
    else
      render json: {
        errors: university.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  def update
    if @university.update(university_params)
      render json: {
        message: "University updated successfully",
        university: UniversitySerializer.new(@university),
      }, status: :ok
    else
      render json: {
        errors: @university.errors.full_messages,
      }, status: :unprocessable_entity
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
