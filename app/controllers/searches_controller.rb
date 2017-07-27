class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '4QW25BRB00IJU3QO4RPJMZPYBZEZPC4UAQ23NJW4JCV4RERS'
      req.params['client_secret'] = 'YUT002BTSHLK3JJWL4OPGM5DLWTALLVE0K3KYBR1IBVJZGSD'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end # end of get

    body = JSON.parse(@resp.body)
    if @resp.success?
        @venues = body["response"]["venues"]
    else
        @error = body["meta"]["errorDetail"]
    end # end of if

    rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
    end # end of rescue
    render 'search'
  end # end of method
end # end of class
