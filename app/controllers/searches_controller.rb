class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '4WPXJI15XFDDWMFZV1WQ2ZA1F4J5HKBRM1KAEZIZ4LNDWE1K'
        req.params['client_secret'] = 'QK0OHU1JKLBG4QMEMLP4H1I50BRKZZQKGMMZFRTAYGDA1KUU'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee'
        
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
