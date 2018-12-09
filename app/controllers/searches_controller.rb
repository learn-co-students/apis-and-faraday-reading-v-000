class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'JRGAB4RKU3OY3EMUUDK4244QMOH4T0ZKQC3G2SIRSTB40LYV'
        req.params['client_secret'] = '52G1B4KKPC4PNWQ1FOGDIQHCSXMAVQQXLBAPOHUIDWHCEJK3'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body = JSON.parse(@response.body)
      if @response.success?
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
