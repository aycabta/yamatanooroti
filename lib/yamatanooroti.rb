require 'test-unit'

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
    when :VTermTestCaseModule
      load_vterm
      Yamatanooroti::VTermTestCaseModule
    when :WindowsTestCase
      load_windows
      Yamatanooroti::WindowsTestCase
    when :WindowsTestCaseModule
      load_windows
      Yamatanooroti::WindowsTestCaseModule
    else
      raise StandardError.new("Unknown class #{id.to_s}")
    end
  end

  def self.win?
    RbConfig::CONFIG['host_os'].match?(/mswin|msys|mingw|cygwin|bccwin|wince|emc/)
  end

  def self.has_vterm_gem?
    begin
      require 'vterm'
    rescue LoadError
      false
    else
      true
    end
  end
end

class Yamatanooroti::TestCase < Test::Unit::TestCase
  @@runners = []

  def self.inherited(klass)
    super
    if ancestors.first == Yamatanooroti::TestCase
      if Yamatanooroti.has_vterm_gem?
        test_klass = Class.new(klass)
        klass.const_set(:TestVTerm, test_klass)
        test_klass.include Yamatanooroti::VTermTestCaseModule
        @@runners << test_klass
      end
      if Yamatanooroti.win?
        test_klass = Class.new(klass)
        klass.const_set(:TestWindows, test_klass)
        test_klass.include Yamatanooroti::WindowsTestCaseModule
        @@runners << test_klass
      end
      if @@runners.empty?
        raise LoadError.new(<<~EOM)
          Any real(?) terminal environments not found.
          Supporting real(?) terminals:
          - vterm gem
          - Windows
        EOM
      end
      def klass.method_added(name)
        super
        if ancestors[1] == Yamatanooroti::TestCase
          @@runners.each do |test_klass|
            test_klass.define_method(name, instance_method(name))
          end
          remove_method name
        end
      end
    end
  end
end
