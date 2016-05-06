class SearchesController < ApplicationController
  def search
  end

  def foursquare

   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = 'TKJN4OUIZQG2WLWSDE0HZDGQS4HX1BNVFJD3EU4D1T33O3UY'
       req.params['client_secret'] = 'D4JAFHM4TF2MIBPQZQFFQEVX2BLNZRPQM5AEB1FZOOYF5EGJ'
       req.params['v'] = '20160201'
       req.params['near'] = params[:zipcode]
       req.params['query'] = 'coffee shop'
       #req.options.timeout = 2   # this is for time out erros for customization
     end
     body = JSON.parse(@resp.body)
     if @resp.success?
       @venues = body["response"]["venues"]
     else
       @error = body["meta"]["errorDetail"]
     end
  #  rescue Faraday::TimeoutError   # executes after timeout
  #   @error = "There was a timeout. Please try again."
  # end

   render 'search'
 end
end
