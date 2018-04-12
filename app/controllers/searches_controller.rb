class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    url = 'https://api.foursquare.com/v2/venues/search'
    
    @resp = Faraday.get url do |req|
      req.params['client_id'] = 'M2MIVJ2INVLHBAXPCTFLR5YY2ICYEWKMEJGRYNP4TBOBUKCZ'
      req.params['client_secret'] = 'BRWBTJNPZ0L0JC2BT4KXD30OYJJMODZ4CB1ANEMU1EICVCAF'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    
    render 'search'
  end
end
