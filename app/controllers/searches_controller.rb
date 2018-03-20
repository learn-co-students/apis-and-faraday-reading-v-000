class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '1JILMDYKNQWZUU2C3V2LY3IK3NG2ITZ4KXEWNJH3BQW0YJHO'
      req.params['client_secret'] = 'B1NWXBM5CA3XHDMMNBEE1RAXRGOGU2A4RHVESHAEIW2YCGKH'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end
    render 'search'
  end
end
