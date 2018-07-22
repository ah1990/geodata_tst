module GoogleMaps

  def nearby_search
    response = Faraday.get(self.nearby_search_url)
    return {} unless response.status == 200

    JSON.parse(response.body)
  end

  def nearby_search_next_page(next_page_token)
    response = Faraday.get(self.next_page_url(next_page_token.to_s))
    return {} unless response.status == 200

    JSON.parse(response.body)
  end

  def nearby_search_url
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV['GOOGLE_MAPS_API']}&location=55.737381,37.622463&radius=10000&language=ru"
  end

  def next_page_url(next_page_token)
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{ENV['GOOGLE_MAPS_API']}&pagetoken=#{next_page_token}&language=ru"
  end

  module_function :nearby_search, :nearby_search_next_page, :nearby_search_url, :next_page_url

end