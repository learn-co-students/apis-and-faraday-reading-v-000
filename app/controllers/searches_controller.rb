class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'JY3WFGVIE40GM3YJRVOKBW2ISIFZ5PT25BHVPJK20E1P4A0Z'
        req.params['client_secret'] = 'KT4HAMM3VZVWNNUOVKTSUYR22R1PH3JI53RVC5JL5SRGHA0F'
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
    render 'search'
  end

end
