class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'EDYSNMRUXQBHOUKRXUVYFADZTHJFI3Q0TJMHEA3FL2RJR5N3'
      req.params['client_secret']  = 'QVI4OTUAFUERUYK3V3HOCBBJ4D3L3RBZRKSU3PEK5DP2ED5Y'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      # req.options.timeout = 0
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash['response']['venues']
    else
      @errors = body_hash['meta']['error_detail']
    end

    rescue Faraday::TimeoutError
      @errors = "There was a timeout. Please try again"
      render 'search'
  end
end
