class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'NDI1Y5VZ4UOUBQTT2EXOYWJD3DGKD0RPF2MORU5MD1BZFK1Y'
      req.params['client_secret'] = '4V3HOBBMLUAYPUGCPS0E4DAON0GAD3LMHFKZRB1GECKUCQEL'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
  
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
    render 'search'
  end
end
