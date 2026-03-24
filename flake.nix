{
  description = "CV LaTeX build environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          tex = pkgs.texlive.combine {
            inherit (pkgs.texlive)
              scheme-medium  # covers geometry, graphicx, hyperref, color
              bibunits
              enumitem
              pdfpages
              titlesec
              psnfss          # provides \usepackage{times}
              ;
          };
        in {
          default = pkgs.mkShell {
            packages = [ tex pkgs.gnumake ];
          };
        });
    };
}