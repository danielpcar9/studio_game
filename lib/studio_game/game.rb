require_relative "player"
require_relative "treasure_trove"
require_relative "auditable"

module StudioGame
  class Game
    include Auditable
    
    attr_reader :title, :players

    def initialize(title)
      @title = title
      @players = []
    end

    def add_player(player)
      @players << player
    end

    def load_players(from_file)
    
      File.readlines(from_file, chomp: true).each do |line|
        player = Player.from_csv(line)
        add_player(player)
      end
    rescue Errno::ENOENT 
      puts "Whoops, #{from_file} not found! "
      exit 1
      end
    

    def save_high_scores(to_file = "high_scores.txt")
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:"
        sorted_players.each do |player|
          file.puts "#{player.name.ljust(20, '.')}#{player.score.round.to_s.rjust(5)}"
        end
      end
    end

    def print_stats
      puts "\nGame stats:"
      puts "-" * 20
      sorted_players.each { |player| puts player }

      @players.each do |player|
        puts "\n#{player.name}'s treasure point totals:"
        player.found_treasures.each { |name, points| puts "#{name}: #{points}" }
        puts "total: #{player.score}"
      end
    end

    def sorted_players
      @players.sort_by { |player| player.score }.reverse
    end

    def play(rounds = 1)
      puts "\n#{title} game is starting!"
      puts "\nThe following treasures can be found:"

      puts TreasureTrove.treasure_items

      puts "\nBefore playing:"
      puts @players

      1.upto(rounds) do |round|
        puts "\nRound #{round} is starting!"

        @players.each do |player|
          number_rolled = roll_die
          case number_rolled
          when 1..2
            player.drain
            puts "#{player.name} got drained!😫"
          when 3..4
            puts "#{player.name} got skipped!😒"
          else
            player.boost
            puts "#{player.name} got boosted!😁"
          end

          treasure = TreasureTrove.random_treasure
          player.found_treasure(treasure.name, treasure.points)
          puts "#{player.name} found a #{treasure.name} worth #{treasure.points} points"
        end
      end

      puts "\nAfter playing:"
      puts @players
    end

    def roll_die
      number = rand(1..6)
      audit(number)
      number
    end

  end
end
