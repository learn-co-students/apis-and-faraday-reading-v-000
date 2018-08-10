class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "K3N5PYYEMEJH3CBNZ2POEOLEBJDZA1OG3LFSLV44YWX245RJ"
      req.params['client_secret'] = "O0DH0GSKTID3EUB3FTG0O55T2ALILJKGQLWWIHVOO3RB1G4H"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'

    end
      body_hash = JSON.parse(@resp.body)

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
