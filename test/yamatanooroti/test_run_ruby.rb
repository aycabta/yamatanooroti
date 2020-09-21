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

  def test_wait_for_startup_message
    code = 'sleep 1; puts "aaa"; sleep 1; puts "bbb"'
    start_terminal(5, 30, ['ruby', '-e', code], startup_message: 'aaa')
    # The start_terminal method waits 1 sec for "aaa" as specified by
    # wait_for_startup_message option and close immediately by the close
    # method at the next line. The next "bbb" after waiting 1 sec more doesn't
    # be caught because I/O is already closed.
    close
    assert_screen(<<~EOC)
      aaa
    EOC
  end
end
