class Genre
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
        song.genre ||= self
        self.songs.include?(song) ? nil : self.songs << song
    end

    def artists
        self.songs.collect {|song| song.artist}.uniq
    end
end