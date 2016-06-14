class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
   req.params['client_id'] = "XP0XKQ4FXQTQW0YTFFHMMLYPUKEL1T3QW4Z3NI4SZTF03KEA"
   req.params['client_secret'] = "LVFG4I5ZZYMQT2MLB1COPDDSH0MNA3FMCXKFXEP5P4NJQOW0"
   req.params['v'] = '20160201'
   req.params['near'] = params[:zipcode]
   req.params['query'] = 'coffee shop'
   req.options.timeout = 0
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
