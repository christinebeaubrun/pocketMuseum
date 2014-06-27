require 'test_helper'
require 'generators/layout/layout_generator'

class LayoutGeneratorTest < Rails::Generators::TestCase
  tests LayoutGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
