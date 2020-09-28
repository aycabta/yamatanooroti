# Yamatanooroti

Yamatanooroti is a multi-platform real(?) terminal testing framework.

Supporting envronments:

- vterm gem
- Windows command prompt

## Usage

You can test the executed result and its rendering on the automatically detected environment that you have at the time, by code below:

```ruby
require 'yamatanooroti'

class MyTest < Yamatanooroti::TestCase
  def setup
    start_terminal(5, 30, ['irb', '-f', '--multiline'])
  end

  def test_example
    write(":a\n")
    close
    assert_screen(['irb(main):001:0> :a', '=> :a', 'irb(main):002:0>', '', ''])
  end
end
```

This code detects some real(?) terminal environments:

- vterm gem (you should install beforehand)
- Windows (you should run on command prompt)

If any real(?) terminal environments not found, it will fail with a message:

```
$ rake
Traceback (most recent call last):
        (snip traceback)
/path/to/yamatanooroti/lib/yamatanooroti.rb:71:in `inherited': Any real(?) terminal environments not found. (LoadError)
Supporting real(?) terminals:
- vterm gem
- Windows
rake aborted!
Command failed with status (1)

Tasks: TOP => default => test
(See full trace by running task with --trace)
```

### Advanced Usage

If you want to specify vterm environment that needs vterm gem, you can use `Yamatanooroti::VTermTestCase`:

```ruby
require 'yamatanooroti'

class MyTest < Yamatanooroti::VTermTestCase
  def setup
    start_terminal(5, 30, ['irb', '-f', '--multiline'])
  end

  def test_example
    write(":a\n")
    close
    assert_screen(['irb(main):001:0> :a', '=> :a', 'irb(main):002:0>', '', ''])
  end
end
```

If you haven't installed vterm gem, this code will fail with a message <q>You need vterm gem for Yamatanooroti::VTermTestCase (LoadError)</q>.

Likewise, you can specify Windows command prompt test by `Yamatanooroti::WindowsTestCase`.

## Method Reference

### `start_terminal(height, width, command, startup_message: nil)`

Starts terminal internally that is sized `height` and `width` with `command` to test the result. The `command` should be an array of strings with a path of command and zero or more options. This should be called in `setup` method.

If `startup_message` is given, `start_terminal` waits for the string to be printed and then returns.

```ruby
code = 'sleep 1; puts "aaa"; sleep 10; puts "bbb"'
start_terminal(5, 30, ['ruby', '-e', code], startup_message: 'aaa')
close
assert_screen(<<~EOC)
  aaa
EOC
# The start_terminal method waits for the output of the "aaa" as specified by
# the startup_message option, the "bbb" after 10 seconds won't come because
# the I/O is closed immediately after it.
```

### `write(str)`

Writes `str` like inputting by a keyboard to the started terminal.

### `close`

Closes the terminal to take the internal rendering result. You must call it before call assertions.

### `assert_screen(expected_lines)`

Asserts the rendering result of the terminal with `expected_lines` that should be an `Array` or a `String` of lines. The `Array` contains blank lines and doesn't contain newline characters, and the `String` contains newline characters at end of each line and doesn't contain continuous last blank lines.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
