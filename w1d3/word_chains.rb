require 'set'

class WordChainer
  attr_reader :dictionary, :all_seen_words

  ALPHABET = ("a".."z").to_a

  def initialize(dictionary_file_name)
    @dictionary = read_dictionary(dictionary_file_name)
  end

  def read_dictionary(file_name)
    dic_set = Set.new
    File.open("dictionary.txt") do |file|
      file.each_line do |line|
        dic_set << line.chomp
      end
    end
    dic_set
  end

  def adjacent_words(word)
    real_adjacent_words = []
    word.length.times do |idx|
      real_adjacent_words += adjacent_at_position(word, idx)
    end
    real_adjacent_words
  end

  def adjacent_at_position(word, pos)
    short_alphabet = ALPHABET - [word[pos]]
    words = []

    short_alphabet.each do |letter|
      new_word = word.dup
      new_word[pos] = letter
      if @dictionary.include? new_word
        words << new_word
      end
    end

    words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    until @current_words.empty?
      @current_words = explore_current_words(target)
    end
    build_path(target)
  end

  def explore_current_words(target)
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.keys.include? adjacent_word
        break if @all_seen_words.include? target

        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end
    new_current_words
  end

  def build_path(target)
    source = @all_seen_words[target]
    return [target] if source.nil?

    build_path(source) + [target]
  end
end


if __FILE__ == $PROGRAM_NAME
  word_chainer = WordChainer.new('dictionary.txt')
  p word_chainer.run(ARGV[0], ARGV[1])
end
