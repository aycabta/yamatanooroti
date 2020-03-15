require 'yamatanooroti'

class Yamatanooroti::TestWindows < Test::Unit::TestCase
  def test_load
    if Yamatanooroti.win?
      assert_nothing_raised do
        Yamatanooroti::WindowsTestCase
      end
    else
      assert_raise(LoadError) do
        Yamatanooroti::WindowsTestCase
      end
    end
  end
end
