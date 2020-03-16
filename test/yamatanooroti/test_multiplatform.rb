require 'yamatanooroti'

class Yamatanooroti::TestMultiplatform < Yamatanooroti::TestCase
  def setup
    start_terminal(5, 30, ['irb', '-f', '--multiline'])
    sleep 0.5
  end

  def teardown
  end

  def test_example
    write(":a\n")
    close
    assert_screen(['irb(main):001:0> :a', '=> :a', 'irb(main):002:0>', '', ''])
  end
end
