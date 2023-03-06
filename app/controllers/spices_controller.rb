class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    spices = Spice.all
    render json: spices, status: :ok
  end

  def create
    new_spice = Spice.create(spice_params)
    render json: new_spice, status: :created
  end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice, status: :ok
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :not_found
  end

  private

  def find_spice
    Spice.find(params[:id])
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def render_not_found_response
    render json: { error: 'Spice not found' }, status: :not_found
  end
end
