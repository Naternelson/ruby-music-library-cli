class Music
    attr_accessor :name
    @@all = []
    def initialize(name)
        self.name = name
    end
    def save
        self.class.all << self
    end
    def self.all
        @@all
    end
    def self.create(name)
        instance = self.new(name)
        instance.save
        instance
        # binding.pry
    end
    def self.destroy_all
        self.all.clear
    end
end