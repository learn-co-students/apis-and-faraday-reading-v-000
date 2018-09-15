class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '1O1SYSJLBY52MDKD1Y3YFM3Z0CHDZU0HDYPW50UZMA2UIJAQ'
      req.params['client_secret'] = 'GJXDPYRWVSKQUAHWS3YV4LVAAWZVLYIQAJUQ1XFKD2PLZDHF'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    @venues = body_hash['response']['venues']
    render 'search'
  end
end
