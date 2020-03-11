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
    end
  end
end
