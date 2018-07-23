class Api::V1::BuildingsController < ApplicationController

  def index
    buildings = get_buildings_in_area_sql
    if buildings.present?
      render status: :ok, json: { buildings: buildings, total: buildings.count }
    else
      render status: :unprocessable_entity, json: { error: true }
    end
  end

  private

  def get_buildings_in_area_sql
    sql = "SELECT full_address,
                   ST_Distance(
                     lonlat :: geography,
                     ST_GeomFromEWKT(
                       'SRID=4326;POINT(#{lon} #{lat})'
                     ) :: geography
                   ) as distance
            FROM buildings
            GROUP BY distance, buildings.full_address
            HAVING ST_Distance(
                     lonlat :: geography,
                     ST_GeomFromEWKT(
                       'SRID=4326;POINT(#{lon} #{lat})'
                     ) :: geography
                   ) < #{distance}
            ORDER BY distance;"

    ActiveRecord::Base.connection.execute(sql)
  end

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
