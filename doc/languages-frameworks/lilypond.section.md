# LilyPond

## Installing LilyPond

### Stable

```bash
nix-env -i lilypond
```

### Unstable

```bash
nix-env -i lilypond-unstable
```

### With Fonts

With all fonts:
```nix
self: super {
  my-lilypond = super.lilypond.with-fonts super.openlilylib-fonts.all;
}
```

With specific fonts, e.g. [Improviso](https://github.com/OpenLilyPondFonts/improviso):
```nix
self: super {
  my-lilypond = super.lilypond-unstable.with-fonts (with super.openlilylib-fonts; [ improviso ]);
}
```
