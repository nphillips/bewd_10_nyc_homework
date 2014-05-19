require 'rspec'
require_relative 'secret_number_game'

class SecretNumberGame
  attr_writer :first_name, :last_name, :secret_number, :guesses
end

describe SecretNumberGame do
  before do
    @secret_number_game = SecretNumberGame.new
  end

  context "#created_by" do
    it "will give the game's creator" do
      @secret_number_game.first_name = "Joe"
      @secret_number_game.last_name = "Leo"

      @secret_number_game.created_by.should include("Joe")
      @secret_number_game.created_by.should include("Leo")
    end
  end

  context "#greeting" do
    it "will greet the player by name" do
      @secret_number_game.greet("Joe").should include("Joe")
    end

    it "will say how many guesses are left" do
      @secret_number_game.guesses = 4
      
      @secret_number_game.greet("Joe").should include("4")
    end
  end

  context "Guessing" do
    before do
      @secret_number_game = SecretNumberGame.new
      @secret_number_game.secret_number = 5
    end

    it "is correct if I guess correctly" do
      @secret_number_game.correct?(5).should be_true
    end

    it "is not correct if I guessed too high" do
      @secret_number_game.correct?(3).should be_false
    end

    it "is not correct if I guessed too low" do
      @secret_number_game.correct?(10).should be_false
    end
  end
end
