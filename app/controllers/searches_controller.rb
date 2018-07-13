class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'QHJBSC5DQDBWNTBOMLAW3PAY3H4OS0ASJTKEYOQ0BW4XJLJV'
      req.params['client_secret'] = 'NZPAD3WCHMBTHIBU51K2U24B224N0XV3UCW0NH5P1XNOIUHS'
      req.params['v'] = '20160213'
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
  render 'search'
end

end
