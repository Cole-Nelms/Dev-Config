" [neo]vim configuration

source ~/.vimrc

lua << EOF

  -- IMPORTANT: config filenames cannot share plugin names
  local modules = { 'settings', 'plugins' }

  -- reload modules when this file is read
  for _, v in pairs(modules) do
    package.loaded[v] = nil
    require(v)
  end

EOF
