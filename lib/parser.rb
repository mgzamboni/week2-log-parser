class Parser
    attr_accessor :file_pathname

    def initialize(file_pathname)
        @file_pathname = file_pathname
    end

    def get_first_line
        if(File.exist?(@file_pathname))
            first_line = File.foreach(@file_pathname).first(1)
        else
            raise "file or directory not found"
        end
    end
end