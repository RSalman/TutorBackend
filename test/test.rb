require 'test/unit'
require 'test/unit/ui/console/testrunner'

class TC_MyTest < Test::Unit::TestCase
  def test_fail
    assert(false, 'Assertion was false.')
  end
end

Test::Unit::UI::Console::TestRunner.run(TC_MyTest)
