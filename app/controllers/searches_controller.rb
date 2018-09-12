class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'AKDNFHB3WEAFZERPQWN33BXJOJ1X5GWBQWCTCPBGUA1KUGGH'
      req.params['client_secret'] = 'RPYHFS0H2W5R2WI3ET2LR5NATTHHI15FLEAKKINZJ5DTTV0G'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @errors = body["meta"]["errorDetail"]
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
    render 'search'
  end
end
