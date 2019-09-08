class SearchesController < ApplicationController
  def search
  end

def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
     req.params['client_id'] = 'GO4NQJONGBVEKQ24ECCVQWH4G1DWLWASODAVWKTLILNHMJ05'
     req.params['client_secret'] = 'FZBQSJ4ECIVWDBBJV4WRFZRS12T4MUZXDBALJD424RJ2Z0RE'
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
