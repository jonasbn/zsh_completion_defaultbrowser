# Test Suite

This directory contains automated tests for the `_defaultbrowser` zsh completion script.

## Test Structure

The test suite consists of:

- **test_helper.zsh** - Common test utilities and assertion functions
- **test_parsers.zsh** - Unit tests for parser functions
- **test_completion.zsh** - Integration tests for completion functionality

## Running Tests

### Run All Tests

```zsh
make test
```

Or directly:

```zsh
./run_tests.zsh
```

### Run Specific Test Suites

Run parser tests only:

```zsh
make test-parsers
```

Run integration tests only:

```zsh
make test-integration
```

## Test Categories

### Parser Tests (test_parsers.zsh)

Tests the `_defaultbrowser_parse_browsers` function with various inputs:

- Standard browser list parsing
- Empty list handling
- Single browser with asterisk marker
- Whitespace trimming
- Browser names with spaces
- Error handling

### Integration Tests (test_completion.zsh)

Tests the completion script structure and integration:

- Completion function existence
- Parser function existence
- Proper #compdef directive
- _describe usage
- Syntax validation

## Test Helpers

### Available Assertions

- `assert_equal expected actual test_name` - Assert two strings are equal
- `assert_array_equal expected actual test_name` - Assert two arrays are equal
- `assert_contains haystack needle test_name` - Assert string contains substring
- `assert_not_empty value test_name` - Assert value is not empty

### Test Output

Tests use color-coded output:

- ✓ (green) - Test passed
- ✗ (red) - Test failed

## Writing New Tests

1. Add test function to appropriate test file
2. Use test helper assertions
3. Call the test function at the bottom of the file
4. Tests use mocked `defaultbrowser` command for predictable results

Example:

```zsh
test_my_feature() {
    defaultbrowser() { echo "Safari"; }
    local result="$(_defaultbrowser_parse_browsers)"
    assert_equal "Safari" "$result" "My test description"
}

test_my_feature
```

## Cleaning Completion Cache

If completion behavior is not working as expected:

```zsh
make clean
```

This removes `~/.zcompdump*` files.
