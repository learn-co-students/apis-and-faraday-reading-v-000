class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'UOX3MF4NP4OC0VAXVAUH4LZIMB1BWBXJZEIJVGAKB3NUCEVM'
      req.params['client_secret'] = 'CW2I3PLY5MLIWMGLCPQ5FIQVCO3MFNSYQSS3LJSIWCLGSB54'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee'
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
