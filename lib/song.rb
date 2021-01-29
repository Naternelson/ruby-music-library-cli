class Song
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []
    def initialize(name, artist=nil, genre=nil)
        self.name = name
        self.artist = artist if artist
        self.genre = genre if genre
        # binding.pry
    end
    def save
        self.class.all << self
    end
    def self.all
        @@all
    end
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end
    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end
    def self.new_from_filename(filename)
        split = filename.split(" - ")
        artist = Artist.find_or_create_by_name(split[0])
        genre = Genre.find_or_create_by_name(split[2].split(".")[0])
        Song.new(split[1],artist,genre)
        # binding.pry
        # song = Song.new(split[0],split[1],split[2])
        # song.artist = split[1]
        # song.genre = split[2].split(".")[0]
    end
    def self.create_from_filename(filename)
        instance = self.new_from_filename(filename)
        instance.save
        instance
    end
end