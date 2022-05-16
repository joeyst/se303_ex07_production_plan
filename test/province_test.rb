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

  # Probing the Boundaries pg. 96
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
      assert_equal(31, no_producers.shortfall)
    end
  end
end
