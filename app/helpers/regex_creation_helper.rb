module RegexCreationHelper
  class RegexCreator
    L33T_BINDINGS = { 'a' => '[a@4]', 'b' => '[b]', 'c' => '[c{(]', 'd' => '[d]', 'e' => '[e3]',
      'f' => '[f]', 'g' => '[g]', 'h' => '[h]', 'i' => '[i|1]', 'j' => '[j]', 'k' => '[k]',
      'l' => '[l|1]', 'm' => '[m]', 'n' => '[n]', 'o' => '[o0]', 'p' => '[p]', 'q' => '[q]',
      'r' => '[r]', 's' => '[s$]', 't' => '[t]', 'u' => '[u]', 'v' => '[v]', 'w' => '[w]',
      'x' => '[x]', 'y' => '[y]', 'z' => '[z7]'}

    ADVANCED_BINDINGS = { 'a' => '[a@4]+', 'b' => '[b]+', 'c' => '[c{(]+', 'd' => '[d]+', 'e' => '[e3]+',
      'f' => '[f]+', 'g' => '[g]+', 'h' => '[h]+', 'i' => '[i|1]+', 'j' => '[j]+', 'k' => '[k]+',
      'l' => '[l|1]+', 'm' => '[m]+', 'n' => '[n]+', 'o' => '[o0]+', 'p' => '[p]+', 'q' => '[q]+',
      'r' => '[r]+', 's' => '[s$]+', 't' => '[t]+', 'u' => '[u]+', 'v' => '[v]+', 'w' => '[w]+',
      'x' => '[x]+', 'y' => '[y]+', 'z' => '[z7]+'}

    WHITESPACE = '(\s|\W)*'

    def create_regex_from_string(source, recognition_strength = 'standard')
      @source = source.downcase
      return already_regex if @source[0] == '/' && @source.last == '/'

      case recognition_strength
      when 'standard'
        return @source
      when 'l33t'
        return l33t
      when 'advanced'
        return advanced
      end

      nil
    end

    private
      def already_regex
        @source.chop!
        @source[1..(@source.length)]
      end

      def l33t
        regex = ''
        @source.split('').each do |character|
          if L33T_BINDINGS[character]
            regex += L33T_BINDINGS[character]
          else
            regex += character
          end
        end
        regex
      end

      def advanced
        regex = ''
        @source.split('').each do |character|
          if ADVANCED_BINDINGS[character]
            regex += ADVANCED_BINDINGS[character] + WHITESPACE
          else
            regex += character + '+'
          end
        end
        regex
      end
  end
end
