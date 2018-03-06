class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'DQJXCMESVRB515RR32YKKHJZELN40EYVFHFFJCV23MSAKRN4'
      req.params['client_secret'] = 'LHPGHVAVIXZAXYCYYO3RNXD15JF2S4GRPTAB1DULUIGWVTKP'
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
  end


end
