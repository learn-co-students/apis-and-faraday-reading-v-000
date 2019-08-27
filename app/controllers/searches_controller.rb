class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'B25OA1TIF13NJ0Y2MOHKYVJWIXLFKKRICCSGMQF54KG1OW01'
        req.params['client_secret'] = 'AOUEXLEWNBMM0HCIQHDJXCFFPGOA0EIXHWO5BPVGUXIFNRU5'
        req.params['v'] = '20160201'
        req.params['m'] = 'foursquare'
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
