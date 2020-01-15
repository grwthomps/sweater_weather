class BackgroundFacade
  def self.retrieve_background(location)
    background_url = UnsplashService.fetch_background(location)[:results]
    if background_url.empty?
      background_url = "https://images.unsplash.com/photo-1546931665-73db142e716f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1867&q=80"
      Background.new(background_url)
    else
      Background.new(background_url[0][:urls][:raw])
    end
  end
end
