class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = BQVLFQD3GY1VKBJJF023QL05S5PZUKJKPURNVUV53GE1ODV2
      req.params['client_secret'] = ABRPAOK3WFYOQ4EBIVEKK2GXAFKOFN53NAF21MUGFP2UDZTB
      req.params['v'] = '20170605'
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
