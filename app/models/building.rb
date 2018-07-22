class Building < ApplicationRecord


  scope :within, -> (longitude, latitude, distance = 4) {
    where(%{
     ST_Distance(lonlat, 'POINT(%f %f)') < %d
    } % [longitude, latitude, distance * 1000])
  }

end
