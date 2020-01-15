class UnsplashService
  def fetch_background(location)
    response = Faraday.get('https://api.unsplash.com/search/photos') do |req|
      req.params['client_id'] = ENV['unsplash_access_key']
      req.params['orientation'] = 'landscape'
      req.params['query'] = location
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end
end
