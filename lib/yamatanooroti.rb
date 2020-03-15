class Yamatanooroti
  def self.load_vterm
    require 'vterm'
    require 'yamatanooroti/vterm'
  rescue LoadError
    raise LoadError.new('You need vterm gem for Yamatanooroti::VTermTestCase')
  end

  def self.load_windows
    unless win?
      raise LoadError.new('You need Windows environment for Yamatanooroti::WindowsTestCase')
    end
    require 'yamatanooroti/windows'
  end

  def self.const_missing(id)
    case id
    when :VTermTestCase
      load_vterm
      Yamatanooroti::VTermTestCase
    when :WindowsTestCase
      load_windows
      Yamatanooroti::WindowsTestCase
    else
      raise StandardError.new("Unknown class #{id.to_s}")
    end
  end

  def self.win?
    RbConfig::CONFIG['host_os'].match?(/mswin|msys|mingw|cygwin|bccwin|wince|emc/)
  end
end
