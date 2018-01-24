class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '1LHOLUK0Q2ARGEHH2NCOFV0NOXLAP3W0S2VTTNZ14HCQNE4J
  '
        req.params['client_secret'] = 'E0GP4ERXBX0SSCREU0IGCYDXX1OGDBAJHUYC3CCLAAHZIZOS
  '
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 4
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
