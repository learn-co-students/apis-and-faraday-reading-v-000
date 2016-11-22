class SearchesController < ApplicationController
  def search
  end

  def foursquare
    # # make a request to the API endpoint.
    # @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    #   # adding any parameters we need through the request object via a hash of params
    #   req.params['client_id'] = "K0CYSKFTQFIIMKVECEHWQ1XZNNJZ5I55HR5D0U2RI1NCDJDU"
    #   req.params['client_secret'] = "1YPCADSUDKNGFSAD0JG2WI3EZOUQ3OZHCBPRBIC0Z3KXWDH2"
    #   req.params['v'] = '20160201'
    #   req.params['near'] = params[:zipcode]
    #   req.params['query'] = 'coffee shop'
    # end
    # body = JSON.parse(@resp.body)
    # if @resp.success?
    #   @venues = body["response"]["venues"]
    # else
    #   @error = body["meta"]["errorDetail"]
    # end
    begin
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
         req.params['client_id'] =  "K0CYSKFTQFIIMKVECEHWQ1XZNNJZ5I55HR5D0U2RI1NCDJDU"
         req.params['client_secret'] = "1YPCADSUDKNGFSAD0JG2WI3EZOUQ3OZHCBPRBIC0Z3KXWDH2"
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
# url = "https://api.foursquare.com/v2/venues/search?client_id=K0CYSKFTQFIIMKVECEHWQ1XZNNJZ5I55HR5D0U2RI1NCDJDU&client_secret=1YPCADSUDKNGFSAD0JG2WI3EZOUQ3OZHCBPRBIC0Z3KXWDH2&v=20161121&near=New York&query=coffee shops"
