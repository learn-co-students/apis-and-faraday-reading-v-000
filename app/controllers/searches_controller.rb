class SearchesController < ApplicationController
  def search
  end

  def foursquare
    #We use Faraday.get(url) to make a request to the API endpoint.
    begin
   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = "YOU5FXC3TNDF1PXNMUWXXIPJ5HQP4DFIQBLHSTKWZGWM5KO5"
       req.params['client_secret'] = "41LO0MPDUAFELAVFM3VJ20V5G32Z5W2FK3XKRCLUHR5ODXBM"
       req.params['v'] = '20160201'
       req.params['near'] = params[:zipcode]
       req.params['query'] = 'coffee shop'
       req.options.timeout = 10
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
