class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "LCQB5P1BUTTIHUTI4LT3QSYEOWBJ1T0W3FTSEKY4OG0FUXBH"
        req.params['client_secret'] = "4YFBCESSCWJAIKRGKGUQJ2EMHR5DMKLW5KHAQAM1WLAETJPG"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)

    if @resp.success?
        @venues = body_hash["response"]["venues"]
    else
        @error = body_hash["meta"]["errorDetail"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
