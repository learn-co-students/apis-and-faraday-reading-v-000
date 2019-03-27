class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = GEDGMK4VAAT3WFGH3MH5SVDBJGQO501QAT2XRKB2VYGW31HH
      req.params['client_secret'] = TMY5BTHSLXV51ROBZIOIYVDDFY1HKN5WTXJBDUAQ0YDCVGGE
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 0
    end
    body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
      render 'search'
    end
  end
