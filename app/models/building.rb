class Building < ApplicationRecord

  scope :within, -> (longitude, latitude, distance = 4) {
    where(%{
     ST_Distance(lonlat, 'POINT(%f %f)') < %d
    } % [longitude, latitude, distance * 1000])
  }

  def self.get_buildings_in_area_sql(lon, lat, distance)
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

end
