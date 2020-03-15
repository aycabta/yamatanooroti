require 'yamatanooroti'

class Yamatanooroti::TestVTerm < Test::Unit::TestCase
  def setup
  end

  def test_load
    if Yamatanooroti.has_vterm_gem?
      assert_nothing_raised do
        Yamatanooroti::VTermTestCase
      end
    else
      assert_raise(LoadError) do
        Yamatanooroti::VTermTestCase
      end
    end
  end
end
