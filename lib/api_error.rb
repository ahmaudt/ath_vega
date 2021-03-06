class APIError < StandardError
    def message
        puts "There was an error getting data. Terminate and try again."
    end
end