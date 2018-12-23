class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'W5SASYAB3HAJFM5JAUOMGFTOIOUHLKMWUYWVJJUSNKDX05X5'
        req.params['client_secret'] = 'UEU0URGFXUJSD02DUP1RO0INWYVIDP4N05H0P2G2EBH0PIVV'
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

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      end

      render 'search'
  end

end
