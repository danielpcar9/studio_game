require_relative "player"

module StudioGame
  class BerserkPlayer < Player
    def initialize(name, health = 150)
      @boost_count = 0
      super(name, health)
    end

    def berserk?
      @boost_count > 5
    end

    def boost
      super
      @boost_count += 1
      puts "#{name} is berserk!" if berserk?  
    end

    def drain
      berserk? ? boost : super
      super 
    end
  end

  if __FILE__ == $0
    berserker = BerserkPlayer.new("berserker", 50)
    6.times { berserker.boost }
    2.times { berserker.drain }
    puts berserker.health
  end
end
