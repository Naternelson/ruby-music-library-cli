class MusicImporter
    attr_accessor :path
    def initialize(file_path)
        self.path = file_path
        # binding.pry
    end
    def files
        Dir.entries(path).grep(/[\w\W]?(.mp3)$/)
    end
    def import 
        self.files.each {|filename| Song.create_from_filename(filename)}
    end
end