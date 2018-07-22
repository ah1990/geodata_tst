class Api::V1::BuildingsController < ApplicationController

  def index
    buildings = get_distance_sql
    if buildings.present?
      render status: :ok, json: { data: buildings, total: buildings.count }
    else
      render status: :unprocessable_entity, json: { error: true }
    end
  end

  private

  def get_distance_sql
    lon = params[:lon]
    lat = params[:lat]
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
                   ) < 4000
            ORDER BY distance;"

    ActiveRecord::Base.connection.execute(sql)
  end
end
