package bootstrap.tabs

@client
Tabs = {{

  tab(dom:dom) =
    (%%tabs.tab%%)(Dom.to_string(dom))

}}
