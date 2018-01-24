class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
     req.params['client_id'] = 'RFGR0SVUB1KK0CRHDP43TYOLZJXL55FB3UQZFQ1GHRXXIQHA'
     req.params['client_secret'] = '03LLZNYVFUHH0Y3DMGMIJOIBCJSTOEPIF4L4EA4EBM2GAWQD'
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

   rescue Faraday::TimeoutError
     @error = "There was a timeout. Please try again."
   end
   render 'search'
 end
end
