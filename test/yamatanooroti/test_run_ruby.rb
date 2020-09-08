require 'yamatanooroti'

class Yamatanooroti::TestRunRuby < Yamatanooroti::TestCase
  def test_winsize
    start_terminal(5, 30, ['ruby', '-rio/console', '-e', 'puts(IO.console.winsize.inspect)'])
    sleep 0.5
    close
    assert_screen(<<~EOC)
      [5, 30]
    EOC
  end
end
