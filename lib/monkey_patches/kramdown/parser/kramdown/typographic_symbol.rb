module Kramdown
  module Parser
    class Kramdown

      # Parse the typographic symbols at the current location.
      def parse_typographic_syms
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        val = TYPOGRAPHIC_SYMS_SUBST[@src.matched]
        if val.kind_of?(Symbol)
          @tree.children << Element.new(:typographic_sym, val, nil, :location => start_line_number, symbol: @src.matched)
        elsif @src.matched == '\\<<'
          @tree.children << Element.new(:entity, ::Kramdown::Utils::Entities.entity('lt'),
                                        nil, :location => start_line_number)
          @tree.children << Element.new(:entity, ::Kramdown::Utils::Entities.entity('lt'),
                                        nil, :location => start_line_number)
        else
          @tree.children << Element.new(:entity, ::Kramdown::Utils::Entities.entity('gt'),
                                        nil, :location => start_line_number)
          @tree.children << Element.new(:entity, ::Kramdown::Utils::Entities.entity('gt'),
                                        nil, :location => start_line_number)
        end
      end
    end
  end
end