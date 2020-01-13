class AmypodeService
  def fetch_antipode_city(lat,lng)
    response = Faraday.get('https://amypode.herokuapp.com/api/v1/antipodes') do |req|
      req.headers['api_key'] = 'oscar_the_grouch'
      req.params['lat'] = lat
      req.params['long'] = lng
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
