class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'V4BJKQBNSRPLI50H0B5MASW1TQWC2SQDXB1OSA5VKN2YFFWM'
      req.params['client_secret'] = '0MQHLIDPNSYQOMANMLDBAN4UUSG2VDSTVMSUDWA454N3LA4V'
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

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    
    render 'search'
  end
end
