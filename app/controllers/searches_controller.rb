class SearchesController < ApplicationController

  def search
  end

  def foursquare
    #  use Faraday.get(url) to make a request to the API endpoint
    # passing a block to the get method
    # adding parameters through the request object via a hash of params
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = Y2ZOIHZUWLKQX33KB1KELMOT2HJFL4TCCT1GANUO5MVPOXYR
      req.params['client_secret'] = D3GDJYURLF0GR0HE4UGXSZUW4OYZRD3CGODNOA5UYCTBZFLC
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end

end
