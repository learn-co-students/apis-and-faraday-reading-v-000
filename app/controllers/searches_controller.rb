class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '5IY35A1ZDYBRK0VYBO0DAFRMFWVFS2R0PV35IUYJ0ECD4MA2'
        req.params['client_secret'] = 'S2MHKKAXVS5FRN54KO2FBAWQOGOYMYZUQCZC3ZCY4FT3LPAG'
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
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
