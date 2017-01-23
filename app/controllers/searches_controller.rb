class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'FNOEEMBMKX0N3X5JJ25VG3FALKG1H1TPNAJ3GXLUX3XO5CYA'
        req.params['client_secret'] = 'CZQWDYC0RIXAYM30VKRWWRCRUOL1MOUEQLVABK1GDWIVTGKK'
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
