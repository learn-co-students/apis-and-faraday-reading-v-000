class SearchesController < ApplicationController
  def search
  end

  def foursquare
   begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
     req.params['client_id'] = '1R043A042CU3J43I51A1SDBRPGPS5GTNNG1YHXPO0FRABQNL'
     req.params['client_secret'] = 'GDHVXLEO4RTKHQJGKN3Z3CMFQCGX4PDF4P0RDY0HXVAEQDPS'
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

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
   render 'search'
 end

end
