class Repository < OpenStruct
    def initialize(args)
        super(args)
    end

    def repo_updated_at
        date = DateTime.parse(updated_at)
        date.strftime('%m/%d/%Y %I:%M%p')
    end

    def owner_login
        return 'None' unless owner

        owner.fetch(:login, 'None')
    end

    def license_name
        return 'None' unless license

        license.fetch(:name, 'None')
    end
end
