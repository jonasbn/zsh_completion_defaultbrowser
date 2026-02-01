# Zsh Completion for defaultbrowser

Zsh completion script for the [defaultbrowser](https://github.com/kerma/defaultbrowser) CLI tool.

## Description

This completion provides browser name suggestions when using the `defaultbrowser` command. It dynamically retrieves the list of available browsers from the `defaultbrowser` command itself.

## Features

- Dynamic completion based on available browsers on your system
- Automatically filters out the current default indicator (asterisk)
- Simple and efficient implementation

## Installation

### Manual Installation

1. Copy the `_defaultbrowser` file to a directory in your `$fpath`
2. Reload your completions:

```zsh
autoload -U compinit && compinit
```

### Using a Custom Directory

If you want to keep completions in a custom directory:

```zsh
# Add to your ~/.zshrc
fpath=(~/path/to/zsh_completion_defaultbrowser $fpath)
autoload -U compinit && compinit
```

### Using Oh-My-Zsh

Copy or symlink the completion file to your Oh-My-Zsh completions directory:

```zsh
mkdir -p ~/.oh-my-zsh/custom/plugins/defaultbrowser
cp _defaultbrowser ~/.oh-my-zsh/custom/plugins/defaultbrowser/
```

Then add `defaultbrowser` to your plugins in `~/.zshrc`:

```zsh
plugins=(... defaultbrowser)
```

## Usage

After installation, you can use tab completion with the defaultbrowser command:

```zsh
defaultbrowser <TAB>
```

This will show all available browsers on your system.

## Example

```zsh
$ defaultbrowser <TAB>
chrome  chromium  firefoxdeveloperedition  safari  iterm2  testing
```

## Requirements

- Zsh shell
- [defaultbrowser](https://github.com/kerma/defaultbrowser) CLI tool installed and available in your PATH

## Testing

This project includes an automated test suite to ensure the completion script works correctly.

### Running Tests

Run all tests:

```zsh
make test
```

Run specific test suites:

```zsh
make test-parsers      # Run parser function tests only
make test-integration  # Run integration tests only
```

Or run the test suite directly:

```zsh
./run_tests.zsh
```

### Test Coverage

The test suite includes:

- **Parser Tests**: Unit tests for the `_defaultbrowser_parse_browsers` function
  - Browser list parsing
  - Whitespace and asterisk handling
  - Edge cases (empty lists, single browsers, errors)

- **Integration Tests**: Validation of completion script structure
  - Function definitions
  - Proper zsh completion directives
  - Syntax validation

See [tests/README.md](tests/README.md) for detailed testing documentation.

### Manual Testing

To test the completion in a clean environment:

```zsh
zsh -f
fpath=(. $fpath)
autoload -U compinit
compinit
# Now test: defaultbrowser <TAB>
```

## License

MIT License - Copyright (c) Jonas B. Nielsen (jonasbn) 2026

## Author

- Jonas B. Nielsen (jonasbn)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## See Also

- [bash_completion_defaultbrowser](https://github.com/jonasbn/bash_completion_defaultbrowser) - Bash completion for defaultbrowser
- [defaultbrowser](https://github.com/kerma/defaultbrowser) - The CLI tool itself
