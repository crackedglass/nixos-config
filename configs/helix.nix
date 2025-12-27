{...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor.line-number = "relative";

      theme = "catppuccin_macchiato";
      editor.cursorline = true;
      editor.color-modes = true;
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.indent-guides.render = true;
      editor.bufferline = "multiple";
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "alejandra";
          };
        }
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "rustfmt";
          };
        }
        {
          name = "typst";
          auto-format = true;
          formatter = {
            command = "typstyle";
          };
        }
        {
          name = "html";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "html"
            ];
          };
        }
        {
          name = "css";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "css"
            ];
          };
        }
      ];
    };
  };
}
