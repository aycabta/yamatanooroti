require 'test-unit'
require 'fiddle/import'
require 'fiddle/types'

module Yamatanooroti::WindowsDefinition
  extend Fiddle::Importer
  dlload 'kernel32.dll', 'psapi.dll', 'user32.dll'
  include Fiddle::Win32Types

  FREE = Fiddle::Function.new(Fiddle::RUBY_FREE, [Fiddle::TYPE_VOIDP], Fiddle::TYPE_VOID)

  typealias 'SHORT', 'short'
  typealias 'HPCON', 'HANDLE'
  typealias 'HWND', 'HANDLE'
  typealias 'HRESULT', 'HANDLE'
  typealias 'LPVOID', 'void*'
  typealias 'SIZE_T', 'size_t'
  typealias 'LPWSTR', 'void*'
  typealias 'LPBYTE', 'void*'
  typealias 'LPCWSTR', 'void*'
  typealias 'LPPROC_THREAD_ATTRIBUTE_LIST', 'void*'
  typealias 'PSIZE_T', 'void*'
  typealias 'DWORD_PTR', 'void*'
  typealias 'LPCVOID', 'void*'
  typealias 'LPDWORD', 'void*'
  typealias 'LPOVERLAPPED', 'void*'
  typealias 'WCHAR', 'SHORT'
  typealias 'LPCWCH', 'void*'
  typealias 'LPSTR', 'void*'
  typealias 'LPCCH', 'void*'
  typealias 'LPBOOL', 'void*'
  typealias 'LPWORD', 'void*'
  typealias 'ULONG_PTR', 'ULONG*'
  typealias 'LONG', 'int'

  Fiddle::SIZEOF_HANDLE = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_HPCON = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_HRESULT = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_DWORD = Fiddle::SIZEOF_LONG
  Fiddle::SIZEOF_WORD = Fiddle::SIZEOF_SHORT

  COORD = struct [
    'SHORT X',
    'SHORT Y'
  ]
  typealias 'COORD', 'DWORD32'

  SMALL_RECT = struct [
    'SHORT Left',
    'SHORT Top',
    'SHORT Right',
    'SHORT Bottom'
  ]
  typealias 'SMALL_RECT*', 'DWORD64*'
  typealias 'PSMALL_RECT', 'SMALL_RECT*'

  SECURITY_ATTRIBUTES = struct [
    'DWORD nLength',
    'LPVOID lpSecurityDescriptor',
    'BOOL bInheritHandle'
  ]
  typealias 'PSECURITY_ATTRIBUTES', 'SECURITY_ATTRIBUTES*'
  typealias 'LPSECURITY_ATTRIBUTES', 'SECURITY_ATTRIBUTES*'

  STARTUPINFOW = struct [
    'DWORD cb',
    'LPWSTR lpReserved',
    'LPWSTR lpDesktop',
    'LPWSTR lpTitle',
    'DWORD dwX',
    'DWORD dwY',
    'DWORD dwXSize',
    'DWORD dwYSize',
    'DWORD dwXCountChars',
    'DWORD dwYCountChars',
    'DWORD dwFillAttribute',
    'DWORD dwFlags',
    'WORD wShowWindow',
    'WORD cbReserved2',
    'LPBYTE lpReserved2',
    'HANDLE hStdInput',
    'HANDLE hStdOutput',
    'HANDLE hStdError'
  ]
  typealias 'LPSTARTUPINFOW', 'STARTUPINFOW*'

  PROCESS_INFORMATION = struct [
    'HANDLE hProcess',
    'HANDLE hThread',
    'DWORD  dwProcessId',
    'DWORD  dwThreadId'
  ]
  typealias 'PPROCESS_INFORMATION', 'PROCESS_INFORMATION*'
  typealias 'LPPROCESS_INFORMATION', 'PROCESS_INFORMATION*'

  INPUT_RECORD_WITH_KEY_EVENT = struct [
    'WORD EventType',
    'BOOL bKeyDown',
    'WORD wRepeatCount',
    'WORD wVirtualKeyCode',
    'WORD wVirtualScanCode',
    'WCHAR UnicodeChar',
    ## union 'CHAR  AsciiChar',
    'DWORD dwControlKeyState'
  ]

  CHAR_INFO = struct [
    'WCHAR UnicodeChar',
    'WORD Attributes'
  ]
  typealias 'PCHAR_INFO', 'CHAR_INFO*'

  PROCESSENTRY32W = struct [
    'DWORD dwSize',
    'DWORD cntUsage',
    'DWORD th32ProcessID',
    'ULONG_PTR th32DefaultHeapID',
    'DWORD th32ModuleID',
    'DWORD cntThreads',
    'DWORD th32ParentProcessID',
    'LONG pcPriClassBase',
    'DWORD dwFlags',
    'WCHAR szExeFile[260]'
  ]
  typealias 'LPPROCESSENTRY32W', 'PROCESSENTRY32W*'

  CONSOLE_FONT_INFOEX = struct [
    'ULONG cbSize',
    'DWORD nFont',
    'DWORD32 dwFontSize',
    'UINT FontFamily',
    'UINT FontWeight',
    'WCHAR FaceName[32]'
  ]
  typealias 'PCONSOLE_FONT_INFOEX', 'CONSOLE_FONT_INFOEX*'

  STD_INPUT_HANDLE = -10
  STD_OUTPUT_HANDLE = -11
  STD_ERROR_HANDLE = -12
  ATTACH_PARENT_PROCESS = -1
  KEY_EVENT = 0x0001
  CT_CTYPE3 = 0x04
  C3_HIRAGANA = 0x0020
  C3_HALFWIDTH = 0x0040
  C3_FULLWIDTH = 0x0080
  C3_IDEOGRAPH = 0x0100
  TH32CS_SNAPPROCESS = 0x00000002
  PROCESS_ALL_ACCESS = 0x001FFFFF
  SW_HIDE = 0

  # HANDLE GetStdHandle(DWORD nStdHandle);
  extern 'HANDLE GetStdHandle(DWORD);', :stdcall
  # BOOL CloseHandle(HANDLE hObject);
  extern 'BOOL CloseHandle(HANDLE);', :stdcall

  # BOOL FreeConsole(void);
  extern 'BOOL FreeConsole(void);', :stdcall
  # BOOL AllocConsole(void);
  extern 'BOOL AllocConsole(void);', :stdcall
  # BOOL AttachConsole(DWORD dwProcessId);
  extern 'BOOL AttachConsole(DWORD);', :stdcall
  # BOOL ShowWindow(HWND hWnd, int nCmdShow);
  extern 'BOOL ShowWindow(HWND hWnd,int nCmdShow);', :stdcall
  # HWND WINAPI GetConsoleWindow(void);
  extern 'HWND GetConsoleWindow(void);', :stdcall
  # BOOL WINAPI SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);
  extern 'BOOL SetConsoleScreenBufferSize(HANDLE, COORD);', :stdcall
  # BOOL WINAPI SetConsoleWindowInfo(HANDLE hConsoleOutput, BOOL bAbsolute, const SMALL_RECT *lpConsoleWindow);
  extern 'BOOL SetConsoleWindowInfo(HANDLE, BOOL, PSMALL_RECT);', :stdcall
  # BOOL WriteConsoleInputW(HANDLE hConsoleInput, const INPUT_RECORD *lpBuffer, DWORD nLength, LPDWORD lpNumberOfEventsWritten);
  extern 'BOOL WriteConsoleInputW(HANDLE, const INPUT_RECORD*, DWORD, LPDWORD);', :stdcall
  # BOOL ReadConsoleOutputW(HANDLE hConsoleOutput, PCHAR_INFO lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, PSMALL_RECT lpReadRegion);
  extern 'BOOL ReadConsoleOutputW(HANDLE, PCHAR_INFO, COORD, COORD, PSMALL_RECT);', :stdcall
  # BOOL WINAPI SetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, PCONSOLE_FONT_INFOEX lpConsoleCurrentFontEx);
  extern 'BOOL SetCurrentConsoleFontEx(HANDLE, BOOL, PCONSOLE_FONT_INFOEX);', :stdcall

  # BOOL CreateProcessW(LPCWSTR lpApplicationName, LPWSTR lpCommandLine, LPSECURITY_ATTRIBUTES lpProcessAttributes, LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles, DWORD dwCreationFlags, LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo, LPPROCESS_INFORMATION lpProcessInformation);
  extern 'BOOL CreateProcessW(LPCWSTR lpApplicationName, LPWSTR lpCommandLine, LPSECURITY_ATTRIBUTES lpProcessAttributes, LPSECURITY_ATTRIBUTES lpThreadAttributes, BOOL bInheritHandles, DWORD dwCreationFlags, LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory, LPSTARTUPINFOW lpStartupInfo, LPPROCESS_INFORMATION lpProcessInformation);', :stdcall
  # HANDLE CreateToolhelp32Snapshot(DWORD dwFlags, DWORD th32ProcessID);
  extern 'HANDLE CreateToolhelp32Snapshot(DWORD, DWORD);', :stdcall
  # BOOL Process32First(HANDLE hSnapshot, LPPROCESSENTRY32W lppe);
  extern 'BOOL Process32FirstW(HANDLE, LPPROCESSENTRY32W);', :stdcall
  # BOOL Process32Next(HANDLE hSnapshot, LPPROCESSENTRY32 lppe);
  extern 'BOOL Process32NextW(HANDLE, LPPROCESSENTRY32W);', :stdcall
  # DWORD GetCurrentProcessId();
  extern 'DWORD GetCurrentProcessId();', :stdcall
  # HANDLE OpenProcess(DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwProcessId);
  extern 'HANDLE OpenProcess(DWORD, BOOL, DWORD);', :stdcall
  # BOOL TerminateProcess(HANDLE hProcess, UINT uExitCode);
  extern 'BOOL TerminateProcess(HANDLE, UINT);', :stdcall
  #BOOL TerminateThread(HANDLE hThread, DWORD dwExitCode);
  extern 'BOOL TerminateThread(HANDLE, DWORD);', :stdcall

  # int MultiByteToWideChar(UINT CodePage, DWORD dwFlags, LPCSTR lpMultiByteStr, int cbMultiByte, LPWSTR lpWideCharStr, int cchWideChar);
  extern 'int MultiByteToWideChar(UINT, DWORD, LPCSTR, int, LPWSTR, int);', :stdcall
  # int WideCharToMultiByte(UINT CodePage, DWORD dwFlags, _In_NLS_string_(cchWideChar)LPCWCH lpWideCharStr, int cchWideChar, LPSTR lpMultiByteStr, int cbMultiByte, LPCCH lpDefaultChar, LPBOOL lpUsedDefaultChar);
  extern 'int WideCharToMultiByte(UINT, DWORD, LPCWCH, int, LPSTR, int, LPCCH, LPBOOL);', :stdcall
  #BOOL GetStringTypeW(DWORD dwInfoType, LPCWCH lpSrcStr, int cchSrc, LPWORD lpCharType);
  extern 'BOOL GetStringTypeW(DWORD, LPCWCH, int, LPWORD);', :stdcall

  typealias 'LPTSTR', 'void*'
  typealias 'HLOCAL', 'HANDLE'
  extern 'DWORD FormatMessage(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId, DWORD dwLanguageId, LPTSTR lpBuffer, DWORD nSize, va_list *Arguments);', :stdcall
  extern 'HLOCAL LocalFree(HLOCAL hMem);', :stdcall
  extern 'DWORD GetLastError();', :stdcall
  FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x00000100
  FORMAT_MESSAGE_FROM_SYSTEM = 0x00001000
  LANG_NEUTRAL = 0x00
  SUBLANG_DEFAULT = 0x01
  extern 'int GetSystemMetrics(int);', :stdcall
  SM_CXMIN = 28
  SM_CYMIN = 29
end

module Yamatanooroti::WindowsTestCaseModule
  DL = Yamatanooroti::WindowsDefinition

  private def setup_console(height, width)

    r = DL.FreeConsole
    error_message(r, 'FreeConsole')
    r = DL.AllocConsole
    error_message(r, 'AllocConsole')
    @output_handle = DL.GetStdHandle(DL::STD_OUTPUT_HANDLE)

=begin
    font = DL::CONSOLE_FONT_INFOEX.malloc
    (font.to_ptr + 0)[0, DL::CONSOLE_FONT_INFOEX.size] = "\x00" * DL::CONSOLE_FONT_INFOEX.size
    font.cbSize = DL::CONSOLE_FONT_INFOEX.size
    font.nFont = 0
    font_size = 72
    font.dwFontSize = font_size * 65536 + font_size
    font.FontFamily = 0
    font.FontWeight = 0
    font.FaceName[0] = "\x00".ord
    r = DL.SetCurrentConsoleFontEx(@output_handle, 0, font)
    error_message(r, 'SetCurrentConsoleFontEx')
=end

    rect = DL::SMALL_RECT.malloc
    rect.Left = 0
    rect.Top = 0
    rect.Right = width - 1
    rect.Bottom = height - 1
    r = DL.SetConsoleWindowInfo(@output_handle, 1, rect)
    error_message(r, 'SetConsoleWindowInfo')

    size = DL.GetSystemMetrics(DL::SM_CYMIN) * 65536 + DL.GetSystemMetrics(DL::SM_CXMIN)
    r = DL.SetConsoleScreenBufferSize(@output_handle, size)
    error_message(r, 'SetConsoleScreenBufferSize')

    size = height * 65536 + width
    r = DL.SetConsoleScreenBufferSize(@output_handle, size)
    error_message(r, 'SetConsoleScreenBufferSize')
    r = DL.ShowWindow(DL.GetConsoleWindow(), DL::SW_HIDE)
    error_message(r, 'ShowWindow')
  end

  private def mb2wc(str)
    size = DL.MultiByteToWideChar(65001, 0, str, str.bytesize, '', 0)
    converted_str = String.new("\x00" * (size * 2), encoding: 'ASCII-8BIT')
    DL.MultiByteToWideChar(65001, 0, str, str.bytesize, converted_str, converted_str.bytesize)
    converted_str
  end

  private def wc2mb(str)
    size = DL.WideCharToMultiByte(65001, 0, str, str.bytesize, '', 0, 0, 0)
    converted_str = "\x00" * (size * 2)
    DL.WideCharToMultiByte(65001, 0, str, str.bytesize, converted_str, converted_str.bytesize, 0, 0)
    converted_str
  end

  private def full_width?(c)
    return false if c.nil? or c.empty?
    wc = mb2wc(c)
    type = Fiddle::Pointer.malloc(Fiddle::SIZEOF_WORD, DL::FREE)
    DL.GetStringTypeW(DL::CT_CTYPE3, wc, wc.bytesize, type)
    char_type = type[0, Fiddle::SIZEOF_WORD].unpack('S').first
    if char_type.anybits?(DL::C3_FULLWIDTH)
      true
    elsif char_type.anybits?(DL::C3_HALFWIDTH)
      false
    elsif char_type.anybits?(DL::C3_HIRAGANA)
      true
    elsif char_type.anybits?(DL::C3_IDEOGRAPH)
      true
    else
      false
    end
  end

  private def quote_command_arg(arg)
    if not arg.match?(/[ \t"]/)
      # No quotation needed.
      return arg
    end

    if not arg.match?(/["\\]/)
      # No embedded double quotes or backlashes, so I can just wrap quote
      # marks around the whole thing.
      return %{"#{arg}"}
    end

    quote_hit = true
    result = '"'
    arg.chars.reverse.each do |c|
      result << c
      if quote_hit and c == '\\'
        result << '\\'
      elsif c == '"'
        quote_hit = true
        result << '\\'
      else
        quote_hit = false
      end
    end
    result << '"'
    result.reverse
  end

  private def launch(command)
    command = %Q{cmd.exe /q /c "#{command}"}
    converted_command = mb2wc(command)
    @pi = DL::PROCESS_INFORMATION.malloc
    (@pi.to_ptr + 0)[0, DL::PROCESS_INFORMATION.size] = "\x00" * DL::PROCESS_INFORMATION.size
    @startup_info_ex = DL::STARTUPINFOW.malloc
    (@startup_info_ex.to_ptr + 0)[0, DL::STARTUPINFOW.size] = "\x00" * DL::STARTUPINFOW.size
    r = DL.CreateProcessW(
      Fiddle::NULL, converted_command,
      Fiddle::NULL, Fiddle::NULL, 0, 0, Fiddle::NULL, Fiddle::NULL,
      @startup_info_ex, @pi
    )
    error_message(r, 'CreateProcessW')
    sleep @wait
  rescue => e
    pp e
  end

  private def error_message(r, method_name)
    return if not r.zero?
    err = DL.GetLastError
    string = Fiddle::Pointer.malloc(Fiddle::SIZEOF_VOIDP)
    DL.FormatMessage(
      DL::FORMAT_MESSAGE_ALLOCATE_BUFFER | DL::FORMAT_MESSAGE_FROM_SYSTEM,
      Fiddle::NULL,
      err,
      0x0,
      string,
      0,
      Fiddle::NULL
    )
    log "ERROR(#{method_name}): #{err.to_s}: #{string.ptr.to_s}"
    DL.LocalFree(string)
  end

  private def log(str)
    puts str
    open('aaa', 'a') do |fp|
      fp.puts str
    end
  end

  def write(str)
    sleep @wait
    str.tr!("\n", "\r")
    records = Fiddle::Pointer.malloc(DL::INPUT_RECORD_WITH_KEY_EVENT.size * str.size * 2, DL::FREE)
    str.chars.each_with_index do |c, i|
      record_index = i * 2
      r = DL::INPUT_RECORD_WITH_KEY_EVENT.new(records + DL::INPUT_RECORD_WITH_KEY_EVENT.size * record_index)
      set_input_record(r, c, true)
      record_index = i * 2 + 1
      r = DL::INPUT_RECORD_WITH_KEY_EVENT.new(records + DL::INPUT_RECORD_WITH_KEY_EVENT.size * record_index)
      set_input_record(r, c, false)
    end
    written_size = Fiddle::Pointer.malloc(Fiddle::SIZEOF_DWORD, DL::FREE)
    r = DL.WriteConsoleInputW(DL.GetStdHandle(DL::STD_INPUT_HANDLE), records, str.size * 2, written_size)
    error_message(r, 'WriteConsoleInput')
  end

  private def set_input_record(r, c, key_down)
    r.EventType = DL::KEY_EVENT
    r.bKeyDown = key_down ? 1 : 0
    r.wRepeatCount = 1
    r.wVirtualKeyCode = 0
    r.wVirtualScanCode = 0
    r.UnicodeChar = c.unpack('U').first
    r.dwControlKeyState = 0
  end

  private def free_resources
    h_snap = DL.CreateToolhelp32Snapshot(DL::TH32CS_SNAPPROCESS, 0)
    pe = DL::PROCESSENTRY32W.malloc
    (pe.to_ptr + 0)[0, DL::PROCESSENTRY32W.size] = "\x00" * DL::PROCESSENTRY32W.size
    pe.dwSize = DL::PROCESSENTRY32W.size
    r = DL.Process32FirstW(h_snap, pe)
    error_message(r, "Process32First")
    process_table = {}
    loop do
      #log "a #{pe.th32ParentProcessID.inspect} -> #{pe.th32ProcessID.inspect} #{wc2mb(pe.szExeFile.pack('S260')).unpack('Z*').pack('Z*')}"
      process_table[pe.th32ParentProcessID] ||= []
      process_table[pe.th32ParentProcessID] << pe.th32ProcessID
      break if DL.Process32NextW(h_snap, pe).zero?
    end
    process_table[DL.GetCurrentProcessId].each do |child_pid|
      kill_process_tree(process_table, child_pid)
    end
    #r = DL.TerminateThread(@pi.hThread, 0)
    #error_message(r, "TerminateThread")
    #sleep @wait
    r = DL.FreeConsole()
    #error_message(r, "FreeConsole")
    r = DL.AttachConsole(DL::ATTACH_PARENT_PROCESS)
    error_message(r, 'AttachConsole')
  end

  private def kill_process_tree(process_table, pid)
    process_table[pid]&.each do |child_pid|
      kill_process_tree(process_table, child_pid)
    end
    h_proc = DL.OpenProcess(DL::PROCESS_ALL_ACCESS, 0, pid)
    if (h_proc)
      r = DL.TerminateProcess(h_proc, 0)
      error_message(r, "TerminateProcess")
      r = DL.CloseHandle(h_proc)
      error_message(r, "CloseHandle")
    end
  end

  def close
    sleep @wait
    # read first before kill the console process including output
    @result = retrieve_screen

    free_resources
  end

  private def retrieve_screen
    char_info_matrix = Fiddle::Pointer.to_ptr("\x00" * (DL::CHAR_INFO.size * (@height * @width)))
    region = DL::SMALL_RECT.malloc
    region.Left = 0
    region.Top = 0
    region.Right = @width
    region.Bottom = @height
    r = DL.ReadConsoleOutputW(@output_handle, char_info_matrix, @height * 65536 + @width, 0, region)
    error_message(r, "ReadConsoleOutputW")
    screen = []
    prev_c = nil
    @height.times do |y|
      line = ''
      @width.times do |x|
        index = @width * y + x
        char_info = DL::CHAR_INFO.new(char_info_matrix + DL::CHAR_INFO.size * index)
        mb = [char_info.UnicodeChar].pack('U')
        if prev_c == mb and full_width?(mb)
          prev_c = nil
        else
          line << mb
          prev_c = mb
        end
      end
      screen << line.gsub(/ *$/, '')
    end
    screen
  end

  def result
    @result
  end

  def assert_screen(expected_lines)
    case expected_lines
    when Array
      assert_equal(expected_lines, @result)
    when String
      assert_equal(expected_lines, @result.join("\n").sub(/\n*\z/, "\n"))
    end
  end

  def start_terminal(height, width, command, wait: 1, startup_message: nil)
    @height = height
    @width = width
    @wait = wait
    @result = nil
    setup_console(height, width)
    launch(command.map{ |c| quote_command_arg(c) }.join(' '))
    case startup_message
    when String
      check_startup_message = ->(message) { message.start_with?(startup_message) }
    when Regexp
      check_startup_message = ->(message) { startup_message.match?(message) }
    end
    if check_startup_message
      loop do
        screen = retrieve_screen.join("\n").sub(/\n*\z/, "\n")
        break if check_startup_message.(screen)
        sleep @wait
      end
    end
  end
end

class Yamatanooroti::WindowsTestCase < Test::Unit::TestCase
  include Yamatanooroti::WindowsTestCaseModule
end
