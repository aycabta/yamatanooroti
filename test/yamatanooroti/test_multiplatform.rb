require 'yamatanooroti'

class Yamatanooroti::TestMultiplatform < Yamatanooroti::TestCase
  def setup
    repl_code = <<~'CODE'
      loop {
        result = Readline.readline('prompt> ')
        puts "=> #{result}"
      }
    CODE
    start_terminal(5, 30, ['ruby', '-rreadline', '-e', repl_code])
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
end
