class SearchesController < ApplicationController
  client_id = 'G4ABPG0PBKYVYCK5ILYKSISV1WIXNHWGTBZXMJQBZD2ENUPY'
  client_secret = 'HSMQN0YIAIVO0QZASHI2B1YCTFDNWKGZ3PZ4LAZ2WXP2NPF4'

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'G4ABPG0PBKYVYCK5ILYKSISV1WIXNHWGTBZXMJQBZD2ENUPY'
        req.params['client_secret'] = 'HSMQN0YIAIVO0QZASHI2B1YCTFDNWKGZ3PZ4LAZ2WXP2NPF4'
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
      @error = 'There was a timeout. Please try agian.'
    end

    render 'search'
  end


end
