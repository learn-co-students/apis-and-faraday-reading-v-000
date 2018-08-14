class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '0KSPTAT1A1USNFAAXP5AEB1CFUACSI0KHEETYJKR2SKD4WDB'
        req.params['client_secret'] = 'STYCZZ2KJXKCWVPH4JY5TYJQVWHRTREPKWT4KNCOD3EYEHA5'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode] 
        req.params['query'] = 'coffee shop'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
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

# We use Faraday.get(url) to make a request to the API endpoint
# To keep it simple, we're going to render the search template again with the result