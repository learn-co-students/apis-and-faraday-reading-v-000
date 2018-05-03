class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'ITPA0BQJR2ZNECQBKRBZAGUHD4YCF1WRS4DBESDQTOWUVJWV'
          req.params['client_secret'] = '04P1UXS3E5T3KS1ECOEL3FXGO0PUQ5K5EVDDCQFSOTV0WT21'
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
