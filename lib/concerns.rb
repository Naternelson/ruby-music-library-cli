module Concerns
    module Findable
        def find_by_name (name)
            self.all.find{|el|el.name == name}
        end
        def find_or_create_by_name(name)
            self.find_by_name(name) ?  self.find_by_name(name) : self.create(name) 
        end
        def create(name)
            instance = self.new(name)
            instance.save
            instance
        end
        def destroy_all
            self.all.clear
        end
    end
end