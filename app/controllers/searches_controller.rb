class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'RXFPGRO0NTB0Y032P3FHWYJMTN1PZWLMCMRLQS41G5F4GODQ'
      req.params['client_secret'] = 'VYNEPDRG0TKELTGZ2U3G4AOJ3XMXSAPFAJ1G0QRCQJBDSQ1Y'
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
