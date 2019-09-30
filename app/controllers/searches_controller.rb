class SearchesController < ApplicationController
  
  def search

  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      #  for the client_id and Client_secret, you are expect to put the real
      # client_Id and client_secret into the code...
      req.params['include CLIENT-ID'] = 'include CLIENT-ID' 
      req.params['INCLUDE client-secret received from the Registred API.[aka foursquare]'] = 'INCLUDE client-secret received from the Registred API.[aka foursquare]'
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

    rescue Faraday::ConnectionFailed
         @error = "There was a timeout. Please try again"
      end
      render 'search'
    end

  end