with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    janet
  ];
  JANET_PATH = "./janet/src/2024";
}
