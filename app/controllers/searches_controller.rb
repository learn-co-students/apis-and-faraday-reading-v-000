class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '1P5TKXWWVAN1BM3J25GUSBV5A40GVSWLD2MBGTCP0VTW1OG1'
      req.params['client_secret'] = 'XMXUCVG2HRRUXAVMQYT4JBYA3YQ0ZJRLQIVVTBIR4WFSQLM2'
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
    render 'search'
  end


end
