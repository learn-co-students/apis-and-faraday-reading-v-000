class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @res = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'HLJR0WFOHGRSSAIC5EQU1U0LKCXEQK3MXTTC1CSYQPCOND1N'
        req.params['client_secret'] = 'MOHY0WYVNQFCSGFMWLJIADFNU2CZIYRQEWKRDTMWEDNPTUYR'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body = JSON.parse(@res.body)
      if @res.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again"
    end

    render 'search'
  end
end
