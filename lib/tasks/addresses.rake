namespace :addresses do

  desc 'Fetch random addresses in Moscow city by google api'
  task :fetch_random_addresses => :environment do
    res = GoogleMaps.nearby_search
    addresses = res['results']

    sleep 4
    next_page = GoogleMaps.nearby_search_next_page(res['next_page_token'])
    (addresses << next_page['results']).flatten!

    sleep 4
    last_page = GoogleMaps.nearby_search_next_page(next_page['next_page_token'])
    (addresses << last_page['results']).flatten!

    addresses = addresses.map { |ads| [ads['geometry']['location'], ads['vicinity']]  }

    addresses.each do |a|
      lonlat = a.first
      full_addr = a.last
      lon = lonlat['lng']
      lat = lonlat['lat']
      Building.create(lonlat: "POINT(#{lon} #{lat})", full_address: full_addr)
    end

  end

end