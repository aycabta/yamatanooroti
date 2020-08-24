require 'yamatanooroti'

class Yamatanooroti::TestRunRuby < Yamatanooroti::TestCase
  def test_winsize
    start_terminal(5, 30, ['ruby', '-rio/console', '-e', 'puts(IO.console.winsize.inspect)'])
    sleep 0.5
    close
    # HACK A process what is spawned in pty stdlib can't get winsize.
    assert_screen(<<~EOC)
      [0, 0]
    EOC
  end
end
