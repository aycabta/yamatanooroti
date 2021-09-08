require 'yamatanooroti'
require 'tmpdir'

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
    code = 'sleep 1; puts "aaa"; sleep 10; puts "bbb"'
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

  def test_move_cursor_and_render
    start_terminal(5, 30, ['ruby', '-rio/console', '-e', 'STDOUT.puts(?A);STDOUT.goto(2,2);STDOUT.puts(?B)'])
    close
    assert_equal(['A', '', '  B', '', ''], result)
  end

  def test_meta_key
    get_into_tmpdir
    start_terminal(5, 30, ['ruby', '-rreline', '-e', 'Reline.readline(%{?})'])
    write('aaa ccc')
    write("\M-b")
    write('bbb ')
    close
    assert_screen(<<~EOC)
      ?aaa bbb ccc
    EOC
  ensure
    get_out_from_tmpdir
  end

  private

  def get_into_tmpdir
    @pwd = Dir.pwd
    suffix = '%010d' % Random.rand(0..65535)
    @tmpdir = File.join(File.expand_path(Dir.tmpdir), "test_yamatanooroti_#{$$}_#{suffix}")
    begin
      Dir.mkdir(@tmpdir)
    rescue Errno::EEXIST
      FileUtils.rm_rf(@tmpdir)
      Dir.mkdir(@tmpdir)
    end
    @inputrc_backup = ENV['INPUTRC']
    @inputrc_file = ENV['INPUTRC'] = File.join(@tmpdir, 'temporaty_inputrc')
    File.unlink(@inputrc_file) if File.exist?(@inputrc_file)
  end

  def get_out_from_tmpdir
    FileUtils.rm_rf(@tmpdir)
    ENV['INPUTRC'] = @inputrc_backup
    ENV.delete('RELINE_TEST_PROMPT') if ENV['RELINE_TEST_PROMPT']
  end
end
