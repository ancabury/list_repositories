class RepositoriesController < ApplicationController
    def index
        @search_term = search_param

        search_service.search
        if search_service.error.blank?
            @repositories = search_service.repositories
        else
            @error = search_service.error
        end
    end

    private

    def search_service
        @search_service ||= GetRepositories.new(search_param)
    end

    def search_param
        params.permit(:search, :page, :per_page)
    end
end
