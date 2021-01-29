class Artist
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs
    @@all = []
    def initialize(name)
        self.name = name
        @songs = []
    end
    def save
        self.class.all << self
    end
    def self.all
        @@all
    end
    
    def add_song(song)
        song.artist ||= self
        self.songs.include?(song) ? nil : self.songs << song
    end

    def genres
        self.songs.collect {|song| song.genre}.uniq
    end
end