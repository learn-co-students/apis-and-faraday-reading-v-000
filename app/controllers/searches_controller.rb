class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "DDPVL0XWRYFIBMZMZC1PUOFMRKAIKYDS0JNHTY5SBZLAMKEX"
      req.params['client_secret'] = "SRQPBMLPIFSKQTHFNHRS1Z03JO2ZOXIBGTXJ1Y4KDM4024FS"
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
