class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'removed'
          req.params['client_secret'] = 'removed'
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
          req.options.timeout = 1
        end
        
        body = JSON.parse(@resp.body)
        if @resp.success?
          @venues = body["response"]["venues"]
        else
          @error = body["meta"]["errorDetail"]
        end
   
      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      end
      render 'search'
      end
    end
    
    # def foursquare
  #   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  #     req.params['client_id'] = 'PBRIAGWRXB4HHJXCSSUOV54WVNAPHWFGFELKN1J4LBIT0G0Q'
  #     req.params['client_secret'] = 'HCEU4BCZIIKOVO0YYK2HFFK4FZ4IZZET1BVOG53EKQKPEOS0'
  #     req.params['v'] = '20160201'
  #     req.params['near'] = params[:zipcode]
  #     req.params['query'] = 'coffee shop'
  #     req.options.timeout = 0
  #   end
    
