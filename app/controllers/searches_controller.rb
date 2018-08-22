class SearchesController < ApplicationController
  def search
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "2DM0HNRP01TPJ4M0X33DEDS35SCKAI2DOVN0OFLYMIX0AARW"
      req.params['client_secret'] = "JRWUAARDCYPKLGI4AKRUMWQNEFUXWLVWZL0ZGALVFXCXY1XF"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "2DM0HNRP01TPJ4M0X33DEDS35SCKAI2DOVN0OFLYMIX0AARW"
      req.params['client_secret'] = "JRWUAARDCYPKLGI4AKRUMWQNEFUXWLVWZL0ZGALVFXCXY1XF"
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
