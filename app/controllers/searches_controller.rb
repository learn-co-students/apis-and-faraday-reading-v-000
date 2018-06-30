class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'NMJ5URTFUOGQI2DHQQ2YL0LY43SPJHFAO2CPGY4B3AU5SFRZ'
        req.params['client_secret'] = 'SDMDOKYXRVPMMAKITOMGUZQEKGJBNGH3SM3WM3V3OAKEYPQ1'
        req.params['v'] = 20160201
        req.params['near'] = 'Austin, TX'
        req.params['zipcode'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = 'There was a timeout. Please try again.'
    end
    render 'search'
  end
end
