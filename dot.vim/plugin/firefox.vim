" plugin/firefox.vim
if !has('ruby')
  finish
endif

ruby << RUBY
module Vim
  def self.var(name)
    evaluate("exists('#{name}')") == '1' ? parse(name) : nil
  end

  CONVERSION = [
    # Number
    proc {|e| evaluate(e).to_i(0) },
    # String
    proc {|e| evaluate(e) },
    # Funcref
    proc {|e|
      proc {|args|
        parse "call(#{e}, [#{args.map {|a| a.inspect }.join(',')}])"
      }
    },
    # List
    proc {|e|
      (0...parse("len(#{e})")).map {|i|
        parse("#{e}[#{i}]")
      }
    },
    # Dictionary
    proc {|e|
      parse("keys(#{e})").inject({}) {|h, k|
        h.merge(k => parse("#{e}['#{k}']"))
      }
    }
  ]

  def self.parse(expr)
    type = evaluate("type(#{expr})").to_i
    CONVERSION[type].call(expr)
  end
end

require 'net/telnet'
require 'singleton'

class Firefox
  include Singleton

  DEFAULT_CONFIG = {
    'host' => 'localhost',
    'port' => 4242,
    'mappings' => [
      [/^/, 'file://']
    ]
  }.freeze

  def initialize
    conf = DEFAULT_CONFIG.merge(Vim.var('g:firefox') || {})
    @conn = Net::Telnet.new('Host' => conf['host'], 'Port' => conf['port'])
    @mappings = conf['mappings'].map {|k, v| [Regexp.compile(k), v] }
  end

  def open(uri)
    set 'content.location.href', uri
  end

  def open_buffer
    return unless path = $curbuf.name and map = @mappings.find {|k, v| k =~ path }
    open path.sub(*map)
  end

  def reload
    call 'content.location.reload', true
  end

  def call(method, *args)
    @conn.cmd("#{method}(#{args.map {|a| a.inspect }.join(',')})")
  end

  def set(prop, value)
    @conn.cmd("#{prop} = #{value.inspect}")
  end
end
RUBY

command! -nargs=1 FirefoxOpen ruby Firefox.instance.open(<q-args>)
command! FirefoxOpenBuffer ruby Firefox.instance.open_buffer
command! FirefoxReload ruby Firefox.instance.reload
command! FirefoxStartObserve autocmd BufWritePost <buffer> :FirefoxReload
command! FirefoxStopObserve autocmd! BufWritePost <buffer>

command! -bar -nargs=1 OpenURL :FirefoxOpen <args>
