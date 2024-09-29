# frozen_string_literal: true

module Tokyu
  class RubyKaigi
    attr_reader :number #: Integer
    attr_reader :members #: Array[String]

    # @rbs number: Integer
    # @rbs return: void
    def initialize(number)
      @number = number
      @members = []
    end

    def join(name)
      members << name
    end

    def say_hello
      puts "Hello! Tokyu RubyKaigi, #{members.join(', ')}"
    end
  end
end

tokyu15 = Tokyu::RubyKaigi.new(15)
tokyu15.join('Alice')
tokyu15.join('Bob')
tokyu15.say_hello
