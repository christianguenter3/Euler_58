require 'test/unit'
require_relative 'Euler58'

class TestSpiral < Test::Unit::TestCase

  def test
    puts Spiral.new(2).get_diagonal_prime_quot
  end

  def test_get_diagonals
    assert_equal([1,3,5,7,9,13,17,21,25], Spiral.new(3).get_diagonals)
  end

  def test_diagonal_prime_quot
    prime_quot = Spiral.new(4).get_diagonal_prime_quot
    assert_equal(true, prime_quot < 0.62 && prime_quot > 0.61)
  end

  def test_get_prime_quote_lower_10
    assert_equal(31,Spiral.get_prime_quote_lower_10)
  end


end

class TestLayer < Test::Unit::TestCase
  LAYER_TEST = { 3 => 5,
                  5 => 9,
                  6 => 11}

  def test_get_side_length
    LAYER_TEST.each { |input,output| assert_equal(output, Layer.new(input).get_side_length )  }
  end

  DIAGONAL = { 1 => [1],
               2 => [3,5,7,9],
               4 => [31,37,43,49]}

  def test_diagonal
    DIAGONAL.each { |input,output| assert_equal(output, Layer.new(input).get_diagonal)  }
  end
end

class TestSpiralGenerator < Test::Unit::TestCase

  SPIRAL_TEST = { 1 => [1],
                  2 => [2,3,4,5,6,7,8,9],
                  3 => [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]}


  def test_spiral_generator
    SPIRAL_TEST.each{|input,output| assert_equal(output, @generator.each(input).to_a) }
  end

  STARTNUM = { 1 => 1,
               2 => 2,
               3 => 10,
               4 => 26,
               5 => 50,
               6 => 82 }

  def test_startnum
    STARTNUM.each { |input, output| assert_equal(output, SpiralGenerator.start_num(input))  }
  end

  def setup
    @generator = SpiralGenerator.new
  end
end