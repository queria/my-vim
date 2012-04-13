
      \   'ruby' : [
      \     {
      \       'command'  : "\<C-n>",
      \       'pattern'  : '\k\k$',
      \       'excluded' : '^$',
      \       'repeat'   : 0,
      \     },
      \     {
      \       'command'  : "\<C-x>\<C-f>",
      \       'pattern'  : (has('win32') || has('win64') ? '\f[/\\]\f*$' : '\f[/]\f*$'),
      \       'excluded' : '[*/\\][/\\]\f*$\|[^[:print:]]\f*$',
      \       'repeat'   : 1,
      \     },
      \     {
      \       'command'  : "\<C-x>\<C-o>",
      \       'pattern'  : '\([^. \t]\.\|^:\|\W:\)$',
      \       'excluded' : (has('ruby') ? '^$' : '.*'),
      \       'repeat'   : 0,
      \     },
      \   ],
