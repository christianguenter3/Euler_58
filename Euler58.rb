require 'Prime'

class Spiral

  def initialize(layers)
    @layers = []
    (1..layers).each{ _add_next_layer }
    @@singleton = self
  end

  def to_s
    @layers.each { |x| x.each { |y| puts y} }
  end

  def get_diagonals
    diagonals = []
    @layers.each { |x| diagonals << x.get_diagonal }
    return diagonals.flatten
  end

  def get_diagonal_prime_quot
    return 1.0 * @prime_count / @elem_count
  end

  def _add_next_layer
    @current_layer ||= 1
    @layers << Layer.new(@current_layer)
    @current_layer += 1

    _recalc_prime_and_elem_count()
  end

  def _recalc_prime_and_elem_count
    @prime_count ||= 0
    @elem_count ||= 0
    diagonals = @layers[-1].get_diagonal
    diagonals.each { |x| @prime_count += 1 if Prime.prime?(x) }
    @elem_count += diagonals.size
  end

  def get_max_side_len
    return @layers[-1].get_side_length
  end

  def self.get_prime_quote_lower_10
    prime_quot = 1.0
    spiral = Spiral.new(1)
    while prime_quot > 0.4
      spiral._add_next_layer
      prime_quot = spiral.get_diagonal_prime_quot
    end
    return @@singleton.get_max_side_len
  end
end

class Layer
  include Enumerable

  def each(&block)
    @layer.each{|x| yield x}
  end

  def initialize(layer_id)
    @layer_id = layer_id
    @layer = SpiralGenerator.new.each(layer_id)
  end

  def get_side_length
     (@layer_id * 2) - 1
  end

  def get_diagonal
    return [1] if @layer_id <= 1
    diagonal = []
    step = calc_step()
    @layer.each_with_index do |x, index|
      diagonal << x if (index + 1) % step == 0
    end
    return diagonal
  end

  def calc_step
    2 + (@layer_id - 2) * 2
  end
end

class SpiralGenerator
  include Enumerable

  def self.start_num(i)
    return i if i <= 2
    start_num ||= 2
    (3..i).each { |x| start_num = ((x-2) * 8) + start_num  }
    return start_num
  end

  def each(layer_id,&block)
    layer = []
    if layer_id <= 1
      layer = [1]
    else
      start_num = SpiralGenerator.start_num(layer_id)
      end_num   = start_num + (8 * (layer_id - 1)) - 1
      (start_num..end_num).each do |x|
        if block_given?
          yield x
        else
          layer << x
        end
      end
    end
    return layer
  end
end