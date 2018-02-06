class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'OSXVLT2O5U5ODKOUKP1B32WPKHDBCSTUFWFV5NK0MMJGDPAF'
      req.params['client_secret'] = 'TKSKZVVBNI1VNVO5KLW1NKHQF1UAFMTSYCMRD1VMWQ04TFW4'
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
    render 'search'
  end
end
