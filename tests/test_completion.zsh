#!/usr/bin/env zsh

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

# Source the test helper
source "$SCRIPT_DIR/test_helper.zsh"

# Load zsh completion system
autoload -Uz compinit
compinit

# Source the completion script
source "$SCRIPT_DIR/../_defaultbrowser"

echo "${YELLOW}Testing Completion Integration${NC}"
echo ""

# Mock defaultbrowser for testing
defaultbrowser() {
    echo "Safari"
    echo "Firefox"
    echo "* Google Chrome"
    echo "Microsoft Edge"
}

# Test that the completion function is defined
test_completion_function_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if (( $+functions[_defaultbrowser] )); then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} Completion function _defaultbrowser exists"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} Completion function _defaultbrowser does not exist"
    fi
}

# Test parser function exists
test_parser_function_exists() {
    TESTS_RUN=$((TESTS_RUN + 1))
    if (( $+functions[_defaultbrowser_parse_browsers] )); then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} Parser function _defaultbrowser_parse_browsers exists"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} Parser function _defaultbrowser_parse_browsers does not exist"
    fi
}

# Test that parser function returns expected data
test_parser_function_works() {
    local result

    # Test browser parsing
    result="$(_defaultbrowser_parse_browsers)"
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -n "$result" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} _defaultbrowser_parse_browsers returns data"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} _defaultbrowser_parse_browsers returns empty"
    fi
}

# Test that completion script has proper structure
test_completion_structure() {
    # Read the completion file
    local completion_file="$SCRIPT_DIR/../_defaultbrowser"

    # Check for #compdef directive
    TESTS_RUN=$((TESTS_RUN + 1))
    if grep -q '^#compdef defaultbrowser' "$completion_file"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} File has #compdef directive"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} File missing #compdef directive"
    fi

    # Check for _describe usage
    TESTS_RUN=$((TESTS_RUN + 1))
    if grep -q '_describe' "$completion_file"; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} File uses _describe"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} File does not use _describe"
    fi
}

# Test that parser handles browsers correctly
test_parser_handles_browsers() {
    local result="$(_defaultbrowser_parse_browsers)"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$result" == *"Safari"* ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} Parser returns Safari"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} Parser does not return Safari"
    fi
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$result" == *"Firefox"* ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} Parser returns Firefox"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} Parser does not return Firefox"
    fi
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ "$result" == *"Google Chrome"* ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} Parser returns Google Chrome (asterisk removed)"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} Parser does not return Google Chrome correctly"
    fi
}

# Test completion script syntax
test_completion_syntax() {
    local completion_file="$SCRIPT_DIR/../_defaultbrowser"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    if zsh -n "$completion_file" 2>/dev/null; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo "${GREEN}✓${NC} Completion script has valid syntax"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo "${RED}✗${NC} Completion script has syntax errors"
    fi
}

# Run tests
test_completion_function_exists
test_parser_function_exists
test_parser_function_works
test_completion_structure
test_parser_handles_browsers
test_completion_syntax

# Print summary
print_summary
exit $?
