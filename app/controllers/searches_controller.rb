class SearchesController < ApplicationController
  def search
  end

  def foursquare
    # handling timeout errors with begin/rescue
    begin
      # get API response data into @resp
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        # indicate params to use in the search
        req.params['client_id'] = "EWUX0ATDJUP14JLVZOIL1RL15H1U3SE0BD0HQZRTLGXUYYS5"
        req.params['client_secret'] = "IGFU5HUXZU1QPTMRYBE4PQZBRLOGUKWVYCXWBX2Y4AJJ00YO"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # handling timeout errors
        req.options.timeout = 0
      end
      # parse the response body to JSON
      body = JSON.parse(@resp.body)
      # handling response status/errors
      if @resp.success?
        # if successful save data of venues into a variable
        @venues = body["response"]["venues"]
      else 
        # if unsuccessful save meta errorDetails
        # @error = body["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
