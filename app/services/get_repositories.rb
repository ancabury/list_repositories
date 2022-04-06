require 'uri'
require 'net/http'
require 'json'

class GetRepositories
    attr_accessor :search_term, :page, :per_page, :uri, :repositories, :error

    def initialize(params)
        @search_term = ActionController::Base.helpers.sanitize(params[:search])
        @page = params[:page] || Rails.configuration.default_page
        @per_page = params[:per_page] || Rails.configuration.default_per_page
        @repositories = []
        @error = []
    end

    def search
        return @repositories = [] if search_term.blank?

        response = Net::HTTP.get_response(uri)
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        unless response.is_a?(Net::HTTPOK)
            @error = parsed_response[:message]
            return
        end

        @repositories = parsed_response
    end

    private

    def uri
       @uri ||= URI(search_url)
    end

    def search_url
        base_url + "&q=#{search_term}"
    end

    def pagination_params
        "?page=#{page}&per_page=#{per_page}"
    end

    def base_url
        Rails.configuration.github_repo_url + pagination_params
    end
end
