// https://www.g104robo.com/entry/jupyter-notebook-vim

// Configure CodeMirror Keymap
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Map jj to <Esc>
  CodeMirror.Vim.map("jj", "<Esc>", "insert");
  
  // 数字や記号を移管するのは無理っぽい･･･
  CodeMirror.Vim.map("H", "<Plug>(vim-binding-0)", "normal");
  CodeMirror.Vim.map("J", "<Plug>(vim-binding-})", "normal");
  CodeMirror.Vim.map("K", "<Plug>(vim-binding-{)", "normal");
  CodeMirror.Vim.map("L", "<Plug>(vim-binding-$)", "normal");
 
  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
  CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
  CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");
});

// Configure Jupyter Keymap
require([
  'nbextensions/vim_binding/vim_binding',
  'base/js/namespace',
], function(vim_binding, ns) {
  // Add post callback
  vim_binding.on_ready_callbacks.push(function(){
    var km = ns.keyboard_manager;
    // Allow Ctrl-2 to change the cell mode into Markdown in Vim normal mode
    km.edit_shortcuts.add_shortcut('ctrl-2', 'vim-binding:change-cell-to-markdown', true);
    // Update Help
    km.edit_shortcuts.events.trigger('rebuild.QuickHelp');
  });
});

// 200214: indentを2に設定
require([
  'base/js/namespace',
  'base/js/events'
], function(IPython, events) {
  events.on("app_initialized.NotebookApp", function () {
    IPython.Cell.options_default.cm_config.indentUnit = 2;
  });
});


