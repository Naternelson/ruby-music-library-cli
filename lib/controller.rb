class MusicLibraryController
    attr_accessor :path
    def initialize(path='./db/mp3s')
        self.path = path
        foo = MusicImporter.new(self.path)
        foo.import
    end
    def call
        # 2.times {puts ""}
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.chomp
        triggers_main(input)
        # self.call if input != 'exit'
    end

    def triggers_main(input)
        case input
        when 'list songs'
            self.list_songs
        when 'list artists'
            self.list_artists
        when 'list genres'
            self.list_genres
        when 'list artist'
            self.list_songs_by_artist
        when 'list genre'
            self.list_songs_by_genre
        when 'play song'
            self.play_song
        when 'exit'
            "Have a great day!"
        else
            puts "Hmm... not quite sure if you spelled that right."
            self.call
        end
    end

    def sort_by_name(music_obj)
        music_obj.sort {|a,b| a.name <=> b.name}
    end

    def list_songs
        list = self.sort_by_name(Song.all)
        i = 1
        list.each do |song|
            puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            i += 1
        end
    end

    def list_artists
        list = self.sort_by_name(Artist.all)
        i = 1
        list.each do |artist|
            puts "#{i}. #{artist.name}"
            i += 1
        end
    end

    def list_genres
        list = self.sort_by_name(Genre.all)
        i = 1
        list.each do |genre|
            puts "#{i}. #{genre.name}"
            i += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp

        artist = Artist.all.find {|artist|artist.name == input}
        return nil if artist == nil

        list = self.sort_by_name(artist.songs)
        
        i = 1
        list.each do |song|
            puts "#{i}. #{song.name} - #{song.genre.name}"
            i += 1
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp

        genre = Genre.all.find {|genre|genre.name == input}
        return nil if genre == nil

        list = self.sort_by_name(genre.songs)

        i = 1
        list.each do |song|
            puts "#{i}. #{song.artist.name} - #{song.name}"
            i += 1
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        songs = self.sort_by_name(Song.all)
        input = gets.chomp
        song = songs[input.to_i - 1]
        # binding.pry
        return nil if song == nil
        return nil if input.to_i > songs.count
        return nil if input.to_i < 1
        # binding.pry
        puts "Playing #{song.name} by #{song.artist.name}"
    end
end