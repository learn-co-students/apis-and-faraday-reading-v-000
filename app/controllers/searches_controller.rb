class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'GYX05I1PGRQZX0SLLSJZGIF1Y3FA500CC2JKPWMOLM1OPMLB'
      req.params['client_secret'] = 'CPT2WJG1I52GVRKHAK0MIFVCTSQNUUIFHS355NACZLEKKQGH'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffe shop'
    end

    body = JSON.parse(@resp.body)
    if @reps.success?
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
