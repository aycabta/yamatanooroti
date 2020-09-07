require 'test-unit'
require 'vterm'
require 'pty'
require 'io/console'

module Yamatanooroti::VTermTestCaseModule
  def start_terminal(height, width, command, wait: 0.1)
    @wait = wait
    @result = nil

    @pty_output, @pty_input, @pid = PTY.spawn('bash', '-c', %[stty rows #{height.to_s} cols #{width.to_s}; "$@"], '--', *command)

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
    Process.kill('KILL', @pid)
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

  def result
    return @result if @result
    @result = []
    rows, cols = @vterm.size
    rows.times do |r|
      @result << ''
      cols.times do |c|
        cell = @screen.cell_at(r, c)
        @result.last << cell.char if cell.char
      end
      @result.last.gsub!(/ *$/, '')
    end
    @result
  end

  def assert_screen(expected_lines)
    actual_lines = result
    case expected_lines
    when Array
      assert_equal(expected_lines, actual_lines)
    when String
      assert_equal(expected_lines, actual_lines.join("\n").sub(/\n*\z/, "\n"))
    end
  end
end

class Yamatanooroti::VTermTestCase < Test::Unit::TestCase
  include Yamatanooroti::VTermTestCaseModule
end
