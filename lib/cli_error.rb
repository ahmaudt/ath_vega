class CliError < NoMethodError
    def message
        puts "Invalid selection. Please try again!"
    end
end