require 'test-unit'
require 'vterm'
require 'pty'

class Yamatanooroti::VTermTestCase < Test::Unit::TestCase
  def setup(height, width, command, wait: 0.1)
    @wait = wait

    @pty_output, @pty_input, @pid = PTY.spawn(*command)

    @vterm = VTerm.new(height, width)
    @vterm.set_utf8(true)

    @screen = @vterm.screen
    @screen.reset(true)

    sync
  end

  def write(str)
    sync
    @pty_input.write(str)
    sync
  end

  def close
    sync
    @pty_input.close
    sync
  end

  private def sync
    loop do
      sleep @wait
      chunk = @pty_output.read_nonblock(1024)
      @vterm.write(chunk)
      chunk = @vterm.read
      @pty_input.write(chunk)
    rescue Errno::EAGAIN, Errno::EWOULDBLOCK
      break
    rescue Errno::EIO # EOF
      break
    rescue IO::EAGAINWaitReadable # emtpy buffer
      break
    end
  end

  def assert_screen(expected_lines)
    actual_lines = []
    rows, cols = @vterm.size
    rows.times do |r|
      actual_lines << ''
      cols.times do |c|
        cell = @screen.cell_at(r, c)
        actual_lines.last << cell.char if cell.char
      end
    end
    assert_equal(expected_lines, actual_lines)
  end
end
