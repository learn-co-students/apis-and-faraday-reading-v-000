class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "IV54IVO3B5OU1VCQ2IVSXLLY4XDYI5FEK4JSOFJN3VJHNRY1"
      req.params['client_secret'] = "DG5HXE1NDNGWFXRJYFPJ3ELNG4OM1X1OEKSJMGZO1IF3MAR2"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
       req.options.timeout = 0
      end
       body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end

    rescue Faraday::TimeoutError
      @error = 'There was a timeout. Please try again.'
    end
    render 'search'
  end
end
