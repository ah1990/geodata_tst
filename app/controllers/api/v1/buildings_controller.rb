class Api::V1::BuildingsController < ApplicationController

  def index
    buildings = Building.get_buildings_in_area_sql(lon, lat, distance)
    if buildings.present?
      render status: :ok, json: { buildings: buildings, total: buildings.count }
    else
      render status: :unprocessable_entity, json: { error: true }
    end
  end

  private

  def lon
    point_params[:lon].to_f
  end

  def lat
    point_params[:lat].to_f
  end

  def distance
    4000
  end

  def point_params
    params.permit(:lon, :lat)
  end

end
