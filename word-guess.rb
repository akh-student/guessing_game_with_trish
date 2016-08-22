wordlist = ["hello", "blue", "bike", "ada"]

require 'rainbow'


class Word

  attr_reader :word

# ----------------------------------- #
  def initialize
    @wordlist = ["HELLO", "BLUE", "BIKE", "ADA"]
    @word = @wordlist[rand(@wordlist.length)]
    @guesses_left = 5
    @guesses_left_ascii = " @ @ @ @ @ "
    @letters_guessed = ""

    @word_array = []
    @word.each_char do |character|
      @word_array << character
    end

    @underscore_word_array = []
    @word.length.times do
      @underscore_word_array << "_ "
    end

    puts Rainbow("****************************************").purple
    puts Rainbow("*                                      *").purple
    puts Rainbow("*    WELCOME TO THE WORD GUESS GAME    *").purple
    puts Rainbow("*                                      *").purple
    puts Rainbow("****************************************\n").purple

    print_ascii
    print_underscore_array
    prompt_user

  end

# ----------------------------------- #
  def print_underscore_array
    underscore_word = ""
    @underscore_word_array.each do |character|
      underscore_word += character
    end
    print "Word: #{underscore_word}\n\n"
  end

# ----------------------------------- #
  def prompt_user
    continue = true
    while continue
      puts "What letter would you like to guess?\nOr, if you think you know the word you can enter it now.\n\n"
      @guess = gets.chomp.upcase
      puts ""

      all_letters = nil
      @guess.each_char do |x|
        all_letters = x =~ /[[:alpha:]]/ ? true : false
        if all_letters == false
          break
        end
      end

      if all_letters == true
        if @guess.length == 1
          check_already_guessed
          check_letter
        else
          check_full_word
        end
      elsif @guess.length == 0
        puts "Ooops, I didn't get that\n\n"
      else
        puts "Please enter alpha characters only.\n\n"
      end
    end
  end

# ----------------------------------- #
def check_already_guessed
  if @letters_guessed.include? @guess
    puts "That's been guessed!"
    prompt_user
  else
    check_letter
  end
end

# ----------------------------------- #
  def check_letter
    @letters_guessed += @guess
    correct_guess = false
    instance_counter = 0
    @word_array.each_index do |x|
      if @word_array[x] == @guess
        @underscore_word_array[x] = "#{@guess} "
        correct_guess = true
        instance_counter += 1
      end
    end

    if correct_guess == false
      puts Rainbow("****************************************").cyan
      puts Rainbow("*                                      *").cyan
      puts Rainbow("*      You guessed the letter #{@guess}.       *").cyan
      puts Rainbow("*   #{@guess} is not contained in the word.    *").cyan
      puts Rainbow("*                                      *").cyan
      puts Rainbow("****************************************\n\n").cyan
      guess_incrementer
    else
      puts Rainbow("****************************************").green
      puts Rainbow("*                                      *").green
      puts Rainbow("*             GREAT GUESS!             *").green
      puts Rainbow("*   #{@guess} appears in the word #{instance_counter} time(s).   *").green
      puts Rainbow("*                                      *").green
      puts Rainbow("****************************************\n\n").green
    end

    print_ascii
    print_underscore_array
    verify_if_won
    prompt_user
  end

# ----------------------------------- #
  def check_full_word
    if @guess == @word
      you_won
      play_again
    else
      puts Rainbow("That wasn't the right answer.").red
      prompt_user
    end
  end

# ----------------------------------- #
def verify_if_won
  current_letters = ""
  @underscore_word_array.each do |place|
    current_letters += place
  current_letters.delete! " "
  end
  if current_letters == @word
    you_won
    play_again
  end
end

# ----------------------------------- #
def you_won
  puts Rainbow("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%").purple
  puts Rainbow("%%                                     %%").purple
  puts Rainbow("%%            YOU WON!!!!!!            %%").purple
  puts Rainbow("%%                                     %%").purple
  puts Rainbow("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n").purple

end

# ----------------------------------- #
  def guess_incrementer
    @guesses_left -= 1
    @guesses_left_ascii.chop!.chop!
    if @guesses_left == 0
      puts Rainbow("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX").red
      puts Rainbow("XX                                     XX").red
      puts Rainbow("XX         YOU LOSE. GAME OVER.        XX").red
      puts Rainbow("XX                                     XX").red
      puts Rainbow("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n").red
      puts "The correct answer was #{@word}\n\n"
      play_again
    end
  end

# ----------------------------------- #
def play_again
  while true
    puts "Would you like to play again?\n1. Yes\n2. No\n\n"
    continue_play = gets.chomp.downcase

    case continue_play
    when "1", "1.", "yes", "y", "1. yes", "1 yes"
      initialize
    when "2", "2.", "no", "n", "2. no", "2 no"
      exit
    else
      puts "I'm sorry; I didn't understand that."
    end
  end
end

# ----------------------------------- #
  def print_ascii
    puts Rainbow("       You have #{@guesses_left} guesses left.\n\n").magenta
    puts Rainbow("             #{@guesses_left_ascii}").magenta
    puts Rainbow("             ,\\,\\,|,/,/,").green
    puts Rainbow("                _\\|/_").green
    puts Rainbow("               |||||||").purple
    puts Rainbow("                |||||").purple
    puts Rainbow("                |||||\n\n").purple
    puts "You have guessed the letter(s): #{@letters_guessed}\n\n"

  end

# Things this program does not do:
# Handle multiple difficulty levels


end



Word.new
