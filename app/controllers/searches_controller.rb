class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'FSHFAAQHXEBSYPROHZNYJCM0TQT1JNJZM3YHZGGC5VLT0ODP'
      req.params['client_secret'] = 'Z2NE1GLNS3PFU1UPM4HWLFDDBISSD0HM32AECVOA5VYK1TTI'
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
