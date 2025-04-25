{
  description = "Meu ambiente personalizado Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # usa a versão mais recente do nixpkgs
    # nixpkgsStable.url = "github:nixos/nixpkgs/nixos-24.11"; # usa a versão mais estável
  };

  outputs = { self, nixpkgs, nixpkgsStable, ... } @ inputs:
    let
      system = "x86_64-linux";
      legacy = "legacyPackages";
      pkgs = nixpkgs.${legacy}.${system};
      # pkgsStable = nixpkgsStable.${legacy}.${system};
      
      # Pacotes base compartilhados
      basePackages = with pkgs; [
        xclip               # Tool to access the X clipboard from a console application
        tmux                # Terminal Multiplexer
        eza                 # A modern alternative for the venerable file-listing command-line program ls
        lazygit             # Simple terminal UI for git commands
        direnv              # Shell extension that manages your environment
        nix-direnv          # Fast, persistent use_nix implementation for direnv
        zoxide              # Fast cd command that learns your habits
        httpie              # Command line HTTP client whose goal is to make CLI human-friendly
        bat                 # Cat(1) clone with syntax highlighting and Git integration
        neovim              # Text editor
        fastfetch           # A fetch, maybe I'll also test 'nitch' something like that
        gh                  # GitHub cli
        fzf                 # Fuzy Finder
        yq-go               # Portable command-line YAML processor
        gcc                 # Compilor
        ripgrep             # Utility that combines the usability of The Silver Searcher with the raw speed of grep
        fd                  # Simple, fast and user-friendly alternative to find
        cargo               # Rust's package manager and build system, it handles dependencies e.g. nil_ls for nix.
      ];

      # Pacotes adicionais específicos para trabalho
      workPackages = with pkgs; [
        slack
        postman
      ];

    in {
      # Ambiente pessoal (home-env)
      packages.${system}.home-env = pkgs.buildEnv {
        name = "home-environment";
        paths = basePackages;
      };

      # Ambiente de trabalho (work-env)
      packages.${system}.work-env = pkgs.buildEnv {
        name = "work-environment";
        # paths = basePackages ++ workPackages;
        paths = basePackages;
      };

      # DevShell para desenvolvimento (opcional)
      devShells.${system}.default = pkgs.mkShell {
        packages = basePackages ++ [ pkgs.rustc pkgs.nodejs pkgs.python3 ];
      };
    };
}