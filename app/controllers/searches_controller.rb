class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'VAVUAG1ID0JCCYE0214JDOC5LWLP40ASP13IZAWDSEPYUC0G'
      req.params['client_secret'] = 'H2VH5BRM11HX1XAWHQLLFZG1QZD3F1PU3WI10QLLMYRGKFGB'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash['response']['venues']
    render 'search'
  end
end
