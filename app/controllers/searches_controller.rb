class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "WCRPNPCXOHFCLOEDHYCX4TLHH3MI5NTAE0I43HSRA45NCXJ4"
        req.params['client_secret'] = "5G3JQELCX4AAT20WF5FH5DOTYSMJSIT3KLTOI2J5MWZNPK5Q"
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
