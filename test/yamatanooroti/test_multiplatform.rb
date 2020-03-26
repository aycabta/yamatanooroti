require 'yamatanooroti'

class Yamatanooroti::TestMultiplatform < Yamatanooroti::TestCase
  def setup
    start_terminal(5, 50, ['ruby', '-rreadline', '-e', %q[puts "=> #{Readline.readline('prompt> ')}"]])
    sleep 0.5
  end

  def test_example
    write(":a\n")
    close
    assert_screen(['prompt> :a', '=> :a', '', '', ''])
    assert_screen(<<~EOC)
      prompt> :a
      => :a
    EOC
  end
end
