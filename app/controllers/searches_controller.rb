class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'CIOQXN0R1GTYNLEIPTVAEI232AKSCKOTJSNDACC4EGHMIN2A'
          req.params['client_secret'] = 'O5YFRGVL55RJG5T24J4RLAQZYRV22N4FXEDBSRHY0TSERUNQ'
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
