class SearchesController < ApplicationController
  @@client_id = 'Y2ZOIHZUWLKQX33KB1KELMOT2HJFL4TCCT1GANUO5MVPOXYR'
  @@client_secret = 'PKIW33OP4J5UARGPHEWID3SGO0TIZ4QUKFTUXUEMDHUXEBDF'

  def search
  end

  def foursquare
    #  use Faraday.get(url) to make a request to the API endpoint
    # passing a block to the get method
    # adding parameters through the request object via a hash of params
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = @@client_id
      req.params['client_secret'] = @@client_secret
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end

end
