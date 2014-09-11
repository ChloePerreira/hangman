# hangman

require "colorize"

# Contains all board possibilities
board_hash = {
        line1: "|".colorize(:white)+"     _________".colorize(:yellow),
        line2:  "|".colorize(:white)+"     |/      |".colorize(:yellow),
        line3: [
                "|".colorize(:white)+"     |".colorize(:yellow),
                "|".colorize(:white)+"     |".colorize(:yellow)+"      (_)".colorize(:blue) # head
        ],
        line4: [
                "|".colorize(:white)+"     |".colorize(:yellow),
                "|".colorize(:white)+"     |".colorize(:yellow)+"       |".colorize(:blue), # body 1
                "|".colorize(:white)+"     |".colorize(:yellow)+"      \\|".colorize(:blue), # left arm2
                "|".colorize(:white)+"     |".colorize(:yellow)+"      \\|/".colorize(:blue) #arms/body 3 why doesn't this work?
        ],
        line5: [
                "|".colorize(:white)+"     |".colorize(:yellow),
                "|".colorize(:white)+"     |".colorize(:yellow)+"       |".colorize(:blue) # torso 1
        ],
        line6: [
                "|".colorize(:white)+"     |".colorize(:yellow), 
                "|".colorize(:white)+"     |".colorize(:yellow)+"      /".colorize(:blue), # leg 1
                "|".colorize(:white)+"     |".colorize(:yellow)+"      / \\".colorize(:blue) #legs 2
        ],
        line7: "|".colorize(:white)+"     |".colorize(:yellow),
        line8: "|".colorize(:white)+" ____".colorize(:green)+"|".colorize(:yellow)+"___".colorize(:green)
}

# Contains word possibilities to be chosen at random
word_array = ["blah", "blargh", "computer", "lunch", "peep", "ostentatious", "ermine", "elegiac"]

# Contains most of the gameplay methods and the board
class Board
        attr_accessor :line1, :line2, :line3, :line4, :line5, :line6, :line7, :line8
        def initialize(board_hash)
                @line1=board_hash[:line1]
                @line2=board_hash[:line2]
                @line3=board_hash[:line3] #
                @line4=board_hash[:line4] #
                @line5=board_hash[:line5] #
                @line6=board_hash[:line6] #
                @line7=board_hash[:line7]
                @line8=board_hash[:line8]
        end

        # These print the different board possibilities depending on the number of wrong answers
        def printEmpty
                puts @line1
                puts @line2
                puts @line3[0]
                puts @line4[0]
                puts @line5[0]
                puts @line6[0]
                puts @line7
                puts @line8
        end

        def oneLose
                puts @line1
                puts @line2
                puts @line3[1]
                puts @line4[0]
                puts @line5[0]
                puts @line6[0]
                puts @line7
                puts @line8
        end

        def twoLose
                puts @line1
                puts @line2
                puts @line3[1]
                puts @line4[1] 
                puts @line5[0]
                puts @line6[0]
                puts @line7
                puts @line8
        end

        def threeLose
                puts @line1
                puts @line2
                puts @line3[1]
                puts @line4[2]
                puts @line5[0]
                puts @line6[0]
                puts @line7
                puts @line8
        end

        def fourLose
                puts @line1
                puts @line2
                puts @line3[1]
                puts @line4[3]
                puts @line5[0]
                puts @line6[0]
                puts @line7
                puts @line8
        end

        def fiveLose
                puts @line1
                puts @line2
                puts @line3[1]
                puts @line4[3]
                puts @line5[1]
                puts @line6[0]
                puts @line7
                puts @line8
        end

        def sixLose
                puts @line1
                puts @line2
                puts @line3[1]
                puts @line4[3]
                puts @line5[1]
                puts @line6[1]
                puts @line7
                puts @line8
        end

        def sevenLose
                puts @line1
                puts @line2
                puts @line3[1]
                puts @line4[3]
                puts @line5[1]
                puts @line6[2]
                puts @line7
                puts @line8
                puts "You lost!"
        end

        # Prints the blank spaces (or partially filled in spaces) after user guesses
        def printSpaces(letter_array, guess_array)
                size = letter_array.size
                i = 0
                space = []
                while i < size
                        if letter_array[i]==guess_array[i]
                                space[i]=guess_array[i]
                        else 
                                space[i]= "__"
                        end
                        i+=1
                end
                puts space.join(" ")
        end
        
        # Displays all of the wrong guesses 
        def displayGuesses(all_guesses_array, guess_array)
                display_array = []
                all_guesses_array.each do |element|
                        if !(guess_array.include?(element))
                                display_array.push(element)
                        end
                end

                        puts "Guesses: #{display_array.join(" ")}"
        end

        # Checks for a win
        def checkWin(letter_array, guess_array)
                if letter_array == guess_array
                        puts "You won!"
                        exit 
                end
        end
end

# A new class for words
class Word
        attr_accessor :word, :letter_array
       
        def initialize(word)
                @word=word
                @letter_array=word.split""
                @size = @letter_array.size
        end

end

# Builds an array of correct guesses, ordered correctly e.g. ["g", "u", nil, "s"    , "s"]
# Outside of Board and Word because it uses objects from both classes
def arrayBuild(guess, letter_array, guess_array) 
        i=0
        size = letter_array.size
        while i < size
                if guess.downcase == letter_array[i]
                        guess_array[i]=guess.downcase
                end
                i+=1
        end
        return guess_array
end

# Main gameplay function
def playGame(word_array, board_hash)
        word = word_array.sample # Picks a random-ish word
        word = Word.new(word) # Assign word object to variable
        letter_array = word.letter_array # Creates an array of that word objects letters
        x = Board.new(board_hash) # Creates a board object assigned to x
        x.printEmpty # Prints an empty board
        guess_array = [] # Only contains correct guesses, parallels letter_array - if user wins, the two will match
        all_guesses = [] # Contains all the letters the user has guessed
        wrong = 0 # Counts the incorrect guesses
        puts "Enter \"exit\" to quit the game."
        x.printSpaces(word.letter_array,guess_array) # Prints the blank spaces
        while true # Gameplay loop
                puts "Guess a letter:"
                guess = gets.chomp
                if guess.downcase == word.word # Checks for correct guess
                        puts "You won!"
                        exit
                elsif guess.downcase == "exit" # Checks for exit
                        exit
                elsif guess.size > 1 # Checks for too many letters in a guess
                        puts "Too many letters!"
                        next
                elsif (all_guesses.include?(guess.downcase)) # Checks for duplicate guess
                        puts "You already guessed that letter!"
                        next
                elsif !(letter_array.include?(guess.downcase)) # Checks for wrong guess
                        wrong += 1
                        arrayBuild(guess,letter_array,guess_array)
                        all_guesses.push(guess.downcase)
                        x.displayGuesses(all_guesses, guess_array)
                elsif (letter_array.include?(guess.downcase)) # Checks for right guess
                        arrayBuild(guess,letter_array,guess_array)
                        puts guess_array.join(" ")
                        all_guesses.push(guess.downcase)
                        x.displayGuesses(all_guesses, guess_array)
                end
                case wrong # Prints board depending on wrong counter
                when 1
                        x.oneLose
                        x.printSpaces(word.letter_array,guess_array)
                        x.checkWin(word.letter_array, guess_array)
                when 2
                        x.twoLose
                        x.printSpaces(word.letter_array,guess_array)
                        x.checkWin(word.letter_array, guess_array)
                when 3
                        x.threeLose
                        x.printSpaces(word.letter_array,guess_array)
                        x.checkWin(word.letter_array, guess_array)
                when 4
                        x.fourLose
                        x.printSpaces(word.letter_array,guess_array)
                        x.checkWin(word.letter_array, guess_array)
                when 5
                        x.fiveLose
                        x.printSpaces(word.letter_array,guess_array)
                        x.checkWin(word.letter_array, guess_array)
                when 6
                        x.sixLose
                        x.printSpaces(word.letter_array,guess_array)
                        x.checkWin(word.letter_array, guess_array)
                when 7
                        x.sevenLose
                        x.printSpaces(word.letter_array,guess_array)
                        puts "You lose! The answer was '#{word.word}'."
                        exit
                else 
                        x.printEmpty
                        x.printSpaces(word.letter_array,guess_array)
                        x.checkWin(word.letter_array, guess_array)
                end
                puts ""
                puts ""
        end
end

playGame(word_array,board_hash)
