require 'yamatanooroti'

class Yamatanooroti::TestMultiplatform < Yamatanooroti::TestCase
  def setup
    start_terminal(5, 30, ['ruby', 'bin/simple_repl'])
    sleep 0.5
  end

  def test_example
    write(":a\n")
    close
    assert_screen(['prompt> :a', '=> :a', 'prompt>', '', ''])
    assert_screen(<<~EOC)
      prompt> :a
      => :a
      prompt>
    EOC
  end

  def test_result
    write(":a\n")
    close
    assert_equal(['prompt> :a', '=> :a', 'prompt>', '', ''], result)
  end

  def test_auto_wrap
    write("12345678901234567890123\n")
    close
    assert_screen(['prompt> 1234567890123456789012', '3', '=> 12345678901234567890123', 'prompt>', ''])
    assert_screen(<<~EOC)
      prompt> 1234567890123456789012
      3
      => 12345678901234567890123
      prompt>
    EOC
  end
end
