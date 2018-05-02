class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'LDWV0QZ13RZWDZRDSC5DZQA4DSTSOP5WFVV25WTKVWI4SF0P'
        req.params['client_secret'] = 'OAKLHQFF1COO2MVVPPEPLOCSONKZTXXOBVCDEGBOPVQRYEKD'
        req.params['m'] = 'foursquare'
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
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
