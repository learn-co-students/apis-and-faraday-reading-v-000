class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'W1VMLHJYEWULNSN4ZVZ1SPC0VGN2JXN5GU2JPUFJBQQT3JEX'
      req.params['client_secret'] = 'DLBKP3R1QGCLP3J0FKOI3RQXZFYUIOETUCRS5TBK43ZPZ0AA'
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
