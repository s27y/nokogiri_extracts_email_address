class Lotto
  attr_accessor :result

  def initialize

  end

  public
  def generator_result(num)
    self.number_of_random_number(num)
  end

  protected
  def number_of_random_number(num)
    arr = Array.new
  while arr.length<num do 
    r = random_number(45)

    if(!arr.include?r)
      arr << r
    end

  end
    arr
  end

  private
  def random_number(max)
    Random.rand(max)
  end
end


l = Lotto.new
p l.generator_result(3)