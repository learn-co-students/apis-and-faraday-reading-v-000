class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = 'SZQ4T1Q1WRU5G2OED0HYL5V43N3UKR1JQ0O2JI0LTKOQIVIX'
       req.params['client_secret'] = '0GXDPTNH3BBJIOLUGULMFV1QPJIE5ZVEGQOLJ50DUZK31O15'
       req.params['v'] = '20160201'
       req.params['near'] = params[:zipcode]
       req.params['query'] = 'bbq'
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
