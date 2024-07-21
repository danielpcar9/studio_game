require_relative "playable"

module StudioGame
  class Player
    include Playable
    attr_accessor :name, :health
    attr_reader  :found_treasures

    def name=(new_name)
      @name = new_name.capitalize
    end

    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def found_treasure(name, points)
      @found_treasures[name] += points  
    end

    def points
      @found_treasures.values.sum
      
    end

    def self.from_csv(line)
      
        name, health = line.split(",")
      Player.new(name, Integer(health))
    rescue ArgumentError
      puts "Ignored Invalid health: #{health}"
      Player.new(name)
    end

    def to_s
      "I'm #{@name} with a health = #{@health}, score = #{score}, and points = #{points}"
    end

    def score
      @health + name.length + points
    end
  end
  
  if __FILE__ == $0
    player = Player.new("jase")
  puts player.name
  puts player.health
  player.boost
  puts player.health
  player.drain
  puts player.health
  end
end