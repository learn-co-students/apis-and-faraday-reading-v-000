class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '3DQOQOBXZ1UISHI5P2QLGLK4DJ3JTQTBUQ55U0HTJYRJ2FYF'
        req.params['client_secret'] = 'QBMX5WIPYLT0ES1TOQXSOWSLU54HTPSJEEBDQL2JXFLWGLVE'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body_hash = JSON.parse(@resp.body)
      @venues = body_hash["response"]["venues"]

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
    end

      render 'search'
  end

end
