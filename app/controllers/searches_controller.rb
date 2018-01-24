class SearchesController < ApplicationController
  def search
  end

  # params in fomr will route to  post '/search', to: 'searches#foursquare'
  def foursquare
    begin # setting a timeout
    # retuns an object representing a 'response'
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      # we need to 'set' some parameters by passing a block to the 'get' method and adding any parameters we need through the request object via a hash of 'params'
      req.params['client_id'] = 'client_id'
      req.params['client_secret'] = 'client_secret'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffe shop'
      # req.options.timeout = 0
    end

    # when making a 'request', the returned object represents a 'response'. this 'response object' has a 'body' part, which is where the server response, such as error messages or JSON results wil be -->
    # <!-- and the status, which is the HTTP code the server returns from the request.
    body = JSON.parse(@resp.body)
    # adding some error handling
    if @resp.success?
      @venues = body['response']['venues']
    else
      @error = body['meta']['errorDetail']
    end
  rescue Faraday::TimeoutError
    @error = 'There was a timeout. Please try again.'
  end
    render 'search'
  end
end
