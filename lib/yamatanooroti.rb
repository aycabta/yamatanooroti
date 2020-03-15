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
  def self.define_env_dependent_test_suite(klass, parent_test_case)
    test_klass = Class.new(klass)
    klass.const_set(:TestVTerm, test_klass)
    test_klass.include parent_test_case
    def klass.method_added(name)
      super
      if ancestors[1] == Yamatanooroti::TestCase
        c = const_get(:TestVTerm)
        c.define_method(name, instance_method(name))
        remove_method name
      end
    end
  end

  def self.inherited(klass)
    super
    if ancestors.first == Yamatanooroti::TestCase
      if Yamatanooroti.has_vterm_gem?
        test_klass = Class.new(klass)
        klass.const_set(:TestVTerm, test_klass)
        test_klass.include Yamatanooroti::VTermTestCaseModule
        def klass.method_added(name)
          super
          if ancestors[1] == Yamatanooroti::TestCase
            c = const_get(:TestVTerm)
            c.define_method(name, instance_method(name))
            remove_method name
          end
        end
      end
      if Yamatanooroti.win?
        test_klass = Class.new(klass)
        klass.const_set(:TestWindows, test_klass)
        test_klass.include Yamatanooroti::WindowsTestCaseModule
        def klass.method_added(name)
          super
          if ancestors[1] == Yamatanooroti::TestCase
            c = const_get(:TestWindows)
            c.define_method(name, instance_method(name))
            remove_method name
          end
        end
      end
    end
  end
end
