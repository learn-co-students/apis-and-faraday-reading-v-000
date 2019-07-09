class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'HEIARKOL34IXUDM4KHNQIFTLAZDW2FFUUO2RXO51AQXZ3B0X'
        req.params['client_secret'] = 'WZHR34FLBAHD21J1HCTBRDVAKD0BO4BZLLF1XFF12UNMY1DH'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
      render 'search'
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."


  end

end
