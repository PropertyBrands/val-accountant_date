require 'date'

if RUBY_VERSION >= '1.9'
  # Modify parsing methods to handle accountant date format correctly.
  class << Date
    # American date format detected by the library.
    ACCOUNTANT_SLASH_DATE_RE = %r_\A\s*(\d{1,2})/(\d{4}|\d{2})_.freeze

    # Alias for stdlib Date._parse
    alias _parse_without_accountant_date _parse

    # Transform accountant dates into ISO dates before parsing.
    def _parse(string, comp=true)
      _parse_without_accountant_date(convert_accountant_to_iso(string), comp)
    end

    if RUBY_VERSION >= '1.9.3'
      # Alias for stdlib Date.parse
      alias parse_without_accountant_date parse

      # Transform accountant dates into ISO dates before parsing.
      def parse(string, comp=true)
        parse_without_accountant_date(convert_accountant_to_iso(string), comp)
      end
    end

    private

    # Transform accountant date fromat into ISO format.
    def convert_accountant_to_iso(string)
      if string.count('/') == 1
        string.sub(ACCOUNTANT_SLASH_DATE_RE){ |m| "#$2-#$1-1" }
      elsif string.length <= 8 and string.count('/') == 0
        convert_date_no_slashes_to_iso(string)
      else
        string
      end
    end

    # Transform date without slashes into ISO format.
    def convert_date_no_slashes_to_iso(string)
      case string.length
      when 8 # ddmmyyyy
        "#{string[4,4]}-#{string[2,2]}-#{string[0,2]}"
      when 7 # dmmyyyy
        "#{string[4,4]}-#{string[2,2]}-#{string[0]}"
      when 6 # ddmmyy
        "#{string[4,2]}-#{string[2,2]}-#{string[0,2]}"
      when 5 # dmmyy
        "#{string[4,2]}-#{string[2,2]}-#{string[0]}"
      when 4 # mmyy
        "#{string[2,2]}-#{string[0,2]}-1"
      when 3 # myy
        "#{string[1,2]}-#{string[0]}-1"
      else
        string
      end
    end
  end

  if RUBY_VERSION >= '1.9.3'
    # Modify parsing methods to handle accountant date format correctly.
    class << DateTime
      # Alias for stdlib Date.parse
      alias parse_without_accountant_date parse

      # Transform accountant dates into ISO dates before parsing.
      def parse(string, comp=true)
        parse_without_accountant_date(convert_accountant_to_iso(string), comp)
      end
    end
  end
end
