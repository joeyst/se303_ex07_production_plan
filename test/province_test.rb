gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/province'
require_relative '../lib/data'

class ProvinceTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:asia) { Province.new(sample_province_data) }

  def test_province_shortfall
    assert_equal(5, asia.shortfall)
  end

  def test_profit_method
    assert_equal(230, asia.profit)
  end

  describe 'no producers' do
    let(:data) {
      {
      name: 'No producers',
      producers: [],
      demand: 30,
      price: 20
      }
    }
    let(:no_producers) { Province.new(data)}

    def test_province_shortfall
      assert_equal(30, no_producers.shortfall)
    end

    def test_province_profit
      assert_equal(0, no_producers.profit)
    end
  end

  def test_province_zero_demand
    asia.demand = 0
    assert_equal(-25, asia.shortfall)
    assert_equal(0, asia.profit)
  end

  def test_province_negative_demand
    asia.demand = -1
    assert_equal(-26, asia.shortfall)
    assert_equal(-10, asia.profit)
  end

  def test_province_empty_string_demand
    asia.demand = ''
    assert_raises (NoMethodError) {asia.shortfall}
  end

  describe 'string for producers' do
    def test_province_empty_producer_string
      data = {
        name: 'String producers',
        producers: '',
        demand: 30,
        price: 20
      }
      assert_raises (NoMethodError) { Province.new(data) }
    end
  end

end
