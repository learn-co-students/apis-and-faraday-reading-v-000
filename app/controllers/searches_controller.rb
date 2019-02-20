class SearchesController < ApplicationController
  
  def search

  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      #  for the client_id and Client_secret, you are expect to put the real
      # client_Id and client_secret into the code...
      req.params['H5HRMRRO30JKHX5HU5HMH4SBCFFHIYBRUI5GNLXLZYZ0L55X'] = 'H5HRMRRO30JKHX5HU5HMH4SBCFFHIYBRUI5GNLXLZYZ0L55X' 
      req.params['VVCOQDVXTR4SOJUKBN53XAUQ0TVEDLHT1KB3X5ARHLPAT1SE'] = 'VVCOQDVXTR4SOJUKBN53XAUQ0TVEDLHT1KB3X5ARHLPAT1SE'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
   end

  
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
      @venues = body_hash["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end      

      resucue Faraday::ConnectionFailed
         @error = "There was a timeout. Please try again"
      end
      render 'search'
    end

  end