class FakeNameGenerator
  def initialize
    @words = {
      :adj        => load_file(RAILS_ROOT + '/db/faker/adjectives.txt'),
      :generic    => load_file(RAILS_ROOT + '/db/faker/generic.txt'),
      :breakfast  => load_file(RAILS_ROOT + '/db/faker/breakfast.txt'),
      :burgers    => load_file(RAILS_ROOT + '/db/faker/burgers.txt'),
      :indian     => load_file(RAILS_ROOT + '/db/faker/indian.txt'),
      :italian    => load_file(RAILS_ROOT + '/db/faker/italian.txt'),
      :mexican    => load_file(RAILS_ROOT + '/db/faker/mexican.txt'),
      :pizzas     => load_file(RAILS_ROOT + '/db/faker/pizzas.txt'),
      :sandwiches => load_file(RAILS_ROOT + '/db/faker/sandwiches.txt'),
      :seafood    => load_file(RAILS_ROOT + '/db/faker/seafood.txt')
    }
  end
  
  def load_file(filename)
    File.open(filename).read.split(/\n/) 
  end

  def generate_name(categories)
    adj = @words[:adj].sample
    if categories.include? 'breakfast' then
      stuff = @words[:breakfast].sample
    elsif categories.include? 'burgers' then
      stuff = @words[:burgers].sample
    elsif (categories.include? 'indian') then
      stuff = @words[:indian].sample
    elsif (categories.include? 'italian') then
      stuff = @words[:italian].sample
    elsif (categories.include? 'mexican') then
      stuff = @words[:mexican].sample
    elsif (categories.include? 'pizzas') then
      stuff = @words[:pizzas].sample
    elsif (categories.include? 'sandwiches') then
      stuff = @words[:sandwiches].sample
    elsif (categories.include? 'seafood') then
      stuff = @words[:seafood].sample
    else
      stuff = @words[:generic].sample
    end
    return "#{adj} #{stuff}"
  end
end
