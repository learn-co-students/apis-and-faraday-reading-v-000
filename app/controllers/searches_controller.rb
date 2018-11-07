class SearchesController < ApplicationController

  def search
  end

  def foursquare
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = 'VZ2CAVORUISX4LRLM5LWPJ2RIE5QWQ0TIHVUQ3H2L52FECNJ'
       req.params['client_secret'] = '0O3UFKTVVWA4FSDRUKSJHNSGIOURLCCVW2UU50XXECR5D22N'
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

      #rescue Faraday::ConnectionFailed do
      #  @error = "There was a timeout. Please try again."
      #end

     render 'search'

  end

end
