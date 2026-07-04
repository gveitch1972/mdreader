# mdreader

A tiny native macOS Markdown viewer. One Swift file, no Xcode project, no Electron — just AppKit, WKWebView, and [marked.js](https://github.com/markedjs/marked) embedded in the binary.

Built because opening VS Code to *read* a Markdown file is overkill.

## Features

- GitHub-style rendering with automatic dark mode
- Live reload — edit the file in any editor, the view updates on save (scroll position preserved, atomic saves handled)
- Tables, fenced code blocks, blockquotes, images (relative paths resolve against the file's directory)
- Opens from the command line or with a file picker
- Window size and position remembered between launches
- ⌘R reload, ⌘W close, ⌘Q quit

## Build

Requires Xcode Command Line Tools (for `swiftc`). No Xcode project needed.

```sh
./build.sh
```

This embeds `marked.min.js` (vendored, v12.0.2) into the binary and compiles with `swiftc -O`. Builds in about two seconds.

## Install

```sh
cp -R mdreader.app /Applications/
ln -s /Applications/mdreader.app/Contents/MacOS/mdreader /usr/local/bin/mdreader
```

To make it the default app for `.md` files, right-click any Markdown file in Finder → Get Info → Open with: mdreader → Change All. (`build.sh` produces `mdreader.app`, a minimal bundle that registers as a Markdown viewer with Launch Services.)

## Usage

```sh
mdreader README.md      # open a file
mdreader                # no argument — file picker
```

## How it works

`main.swift` (~200 lines) creates an `NSWindow` with a `WKWebView`, converts the Markdown to HTML in-page with marked.js, and watches the file with a `DispatchSource` for live reload. `build.sh` base64-encodes `marked.min.js` into a generated `MarkedJS.swift` so the binary is fully self-contained.

## License

MIT
