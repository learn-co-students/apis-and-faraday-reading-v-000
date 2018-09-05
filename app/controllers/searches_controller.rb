class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '52AJY54BZSRWZZ25T1STPBCMLF4AXGXV4RINHQPODIPWTEPB'
      req.params['client_secret'] = 'YNZIVP1XGE5T23ENOV2UQT4TDQW5N2HECVMRCBITXLQDJA25'
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
  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
    render 'search'
  end
end
