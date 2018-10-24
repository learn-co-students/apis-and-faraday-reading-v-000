class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "RA4GOBPW3RA5DSNUQKW0HLBHH3NA1IAETL5Z3VS0TJ4IRABN"
      req.params['client_secret'] = "VMNGJU2SARINOWYOLIH1EAPYVHW4QGY4NEEG5VIPKWSJCMP0"
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