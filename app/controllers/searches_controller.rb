class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = '05RYYCBCOTV4PUJEXWQI4NV0Z0K2OMLH0O3F5IM414MJXSCH'
          req.params['client_secret'] = 'ISADUACORBROJ2KHUD342T0GL0YY2MAJS1IBVT4PZFEMVQS4'
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
