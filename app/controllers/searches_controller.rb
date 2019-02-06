class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get
    "https://api.foursquare.com/v2/venues/search" do |req|
      req.params['client_id'] = WPFHOMJ0433AIKNJ5XWLNE4FJOUJK23X2I5NSKKIL15DHR54
      req.params['client_secret'] = 1VGXYGNO0LVGYQCMOZB5BODIWJJ1NGVKLVJ32DK4GRKBMMWE
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
