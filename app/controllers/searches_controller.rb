class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'B42YWNXNAW4CHNHAMGMPHU5IGRSMKNR1GHKZAYIHRST2F0TY'
      req.params['client_secret'] = 'IYG3AA4S0UKQCU1W5ET3QRZ43EGASWTB4WC0HQMT1LYB3JOR'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body['meta']['errorDetail']
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again"
    render 'search'
  end
end
end
