require "kramdown"
require "active_support"
require "active_support/core_ext"
require "pp"

require "markdown_formatter/version"
require "markdown_formatter/ast"
require "markdown_formatter/cli"

require "markdown_formatter/nodes/base"
require "markdown_formatter/nodes/link"
require "markdown_formatter/nodes/leaf_block"
require "markdown_formatter/nodes/blank"
require "markdown_formatter/nodes/leaf_block"
require "markdown_formatter/nodes/container_block"
require "markdown_formatter/nodes/inline"
require "markdown_formatter/nodes/code_span"
require "markdown_formatter/nodes/emphasis"
require "markdown_formatter/nodes/entity"
require "markdown_formatter/nodes/image"
require "markdown_formatter/nodes/header"
require "markdown_formatter/nodes/thematic_break"
require "markdown_formatter/nodes/paragraph"
require "markdown_formatter/nodes/smart_quote"
require "markdown_formatter/nodes/strong"
require "markdown_formatter/nodes/html_element"
require "markdown_formatter/nodes/code_block"
require "markdown_formatter/nodes/footnote"
require "markdown_formatter/nodes/typographic_sym"
require "markdown_formatter/nodes/list_item"
require "markdown_formatter/nodes/list"
require "markdown_formatter/nodes/block_quote"

# Monkey Patch
require "monkey_patches/kramdown/parser/kramdown/autolink"
require "monkey_patches/kramdown/parser/kramdown/blockquote"
require "monkey_patches/kramdown/parser/kramdown/code_span"
require "monkey_patches/kramdown/parser/kramdown/emphasis"
require "monkey_patches/kramdown/parser/kramdown/escaped_chars"
require "monkey_patches/kramdown/parser/kramdown/footnote"
require "monkey_patches/kramdown/parser/kramdown/link"
require "monkey_patches/kramdown/parser/kramdown/html"
require "monkey_patches/kramdown/parser/kramdown/typographic_symbol"
require "monkey_patches/kramdown/parser/kramdown/list"
require "monkey_patches/kramdown/parser/kramdown/header"
require "monkey_patches/kramdown/parser/kramdown/paragraph"
require "monkey_patches/kramdown/parser/kramdown/code_block"
require "monkey_patches/kramdown/utils/entities"
require "monkey_patches/kramdown/parser/gfm"

module MarkdownFormatter
  OPTIONS = {}

  def self.format(source)
    AST.new(source).to_s
  end
end
