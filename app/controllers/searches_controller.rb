class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin 
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'HAZL4SYMZ0QMZONO2B5ZRZPYYWNWNTQ2POPXURFW13SCLHMK'
        req.params['client_secret'] = 'CJX2BMUAKMC2H5J1ZDYHQBWO33BNDMFUV4FMXRDB2HNM1LQL'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
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
