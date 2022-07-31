# nim-xkbcommon

A 1:1 Nim wrapper for [libxkbcommon](https://xkbcommon.org/).

These bindings are currently quite C-like, and subject to cleanup in the future (though they do follow Nim naming conventions).
The `keysyms.nim` file in particular is nasty: Constants describing specific keyboard keys are pretty much the antithesis to style insensitivity.

## Installation and Usage

`nimble install xkb`

## Todo

- [ ] Write some tests
- [ ] Replace all the `ptr T` parameters with ptr types
- [ ] `init(t: typedesc[T])` style init functions
- [ ] Potential higher level bindings: look into [zig-xkbcommon](https://github.com/ifreund/zig-xkbcommon) and [xkbcommon-rs](https://github.com/rust-x-bindings/xkbcommon-rs)
