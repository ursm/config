" plugin/trac-ticket.vim
"
" 使い方:
" TracTicket コマンドでプロジェクトのチケット一覧を取得します。
"  :TracTicket http://hoge.com/trac/proj1
"  :TracTicket http://user:pass@fuga.com/trac/proj2
"
" 取得するチケットの条件を指定することができます。
"  :TracTicket http://hoge.com/trac/proj1 owner=ursm
" 省略時はクローズされていないチケットすべてです。
"
" チケット一覧では以下の操作が行えます。
"  <CR> 現在行のチケット番号を直前に開いていたバッファに挿入し、一覧を閉じる
"  o    現在行のチケットのページをブラウザで開く
"  q    一覧を閉じる
"
" o は :OpenURL コマンドを使用してブラウザを開きます。
" rails.vim を導入している場合は自動的に定義されているはずです。

if !has('ruby')
  finish
endif

ruby << RUBY
require 'xmlrpc/client'

def list_tickets(root_url, query = 'status!=closed')
  @memo = {
    :buf => $curbuf,
    :pos => $curwin.cursor
  }

  client = XMLRPC::Client.new2(URI.join(root_url, 'xmlrpc').to_s)
  procs = client.call('ticket.query', query).map {|i| ['ticket.get', i] }

  tickets = client.multicall(*procs).map {|id, created, updated, attrs|
    "##{id} #{attrs['summary']}"
  }.join('\<CR>').gsub('"', '\"')

  Vim.command(<<-CMD)
    new
    resize 10
    wincmd R

    setlocal previewwindow bufhidden=delete nobackup noswapfile nobuflisted nowrap buftype=nofile
    nmap <buffer><silent> <CR> :ruby insert_id<CR>
    nmap <buffer><silent> o :ruby open_ticket(#{root_url.inspect})<CR>
    nmap <buffer><silent> q :bd<CR>

    exe "normal i#{tickets}"
    setlocal nomodifiable
    goto 1
  CMD
end

def open_ticket(root_url)
  return unless id = current_id
  url = URI.join(root_url, "ticket/#{id}")
  Vim.command("OpenURL #{url}")
end

def insert_id
  return unless id = current_id
  buf = @memo[:buf]
  row, col = @memo[:pos]
  line = buf[row]
  line[col, 0] = "##{id}"
  buf[row] = line
  Vim.command('bd')
end

def current_id
  /^#(\d+)/ =~ $curbuf.line && $1
end
RUBY

command! -nargs=+ TracTicket ruby list_tickets(<f-args>)
