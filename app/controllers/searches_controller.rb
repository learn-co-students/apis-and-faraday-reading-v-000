class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'LVH4ZHGUJKHXRU5400VSS4I2FIB1XCZK3TF2QKKBR5BV422C'
      req.params['client_secret'] = 'A5WZTIPVTSN3QALIGCWN0THQOTUJH5TPHRQSGMW4QUG0AZKO'
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
