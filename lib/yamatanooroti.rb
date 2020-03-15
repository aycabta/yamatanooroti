class Yamatanooroti
  def Yamatanooroti.const_missing(id)
    case id
    when :VTermTestCase
      begin
        require 'vterm'
        require 'yamatanooroti/vterm'
        Yamatanooroti::VTermTestCase
      rescue LoadError
        raise LoadError.new('You need vterm gem for Yamatanooroti::VTermTestCase')
      end
    when :WindowsTestCase
      unless RbConfig::CONFIG['host_os'].match?(/mswin|msys|mingw|cygwin|bccwin|wince|emc/)
        raise LoadError.new('You need Windows environment for Yamatanooroti::WindowsTestCase')
      end
      require 'yamatanooroti/windows'
      Yamatanooroti::WindowsTestCase
    end
  end
end
