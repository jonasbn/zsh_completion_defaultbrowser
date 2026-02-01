#!/usr/bin/env zsh

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

# Source the test helper
source "$SCRIPT_DIR/test_helper.zsh"

# Source the completion script
source "$SCRIPT_DIR/../_defaultbrowser"

echo "${YELLOW}Testing Parser Functions${NC}"
echo ""

# Mock defaultbrowser command for testing
defaultbrowser() {
    cat << 'EOF'
Safari
Firefox
* Google Chrome
Microsoft Edge
Brave Browser
EOF
}

# Test 1: _defaultbrowser_parse_browsers
test_parse_browsers() {
    local result="$(_defaultbrowser_parse_browsers)"
    local expected="Safari
Firefox
Google Chrome
Microsoft Edge
Brave Browser"

    assert_equal "$expected" "$result" "Parse browsers and remove asterisk markers"
}

# Test 2: Empty list handling
test_parse_empty_list() {
    defaultbrowser() { echo ""; }
    local result="$(_defaultbrowser_parse_browsers)"

    assert_equal "" "$result" "Handle empty list gracefully"
}

# Test 3: Single browser in list
test_parse_single_browser() {
    defaultbrowser() { echo "* Safari"; }
    local result="$(_defaultbrowser_parse_browsers)"

    assert_equal "Safari" "$result" "Handle single browser with asterisk"
}

# Test 4: Whitespace handling
test_parse_whitespace() {
    defaultbrowser() {
        echo "  Safari"
        echo "    Firefox  "
        echo "  * Google Chrome  "
    }

    local result="$(_defaultbrowser_parse_browsers)"
    local expected="Safari
Firefox
Google Chrome"

    assert_equal "$expected" "$result" "Trim leading whitespace and remove asterisks"
}

# Test 5: Multiple browsers with asterisk
test_parse_with_asterisk() {
    defaultbrowser() {
        echo "Safari"
        echo "* Firefox"
        echo "Google Chrome"
    }

    local result="$(_defaultbrowser_parse_browsers)"
    assert_contains "$result" "Safari" "Contains Safari"
    assert_contains "$result" "Firefox" "Contains Firefox (asterisk removed)"
    assert_contains "$result" "Google Chrome" "Contains Google Chrome"
}

# Test 6: Browser names with spaces
test_parse_browser_names_with_spaces() {
    defaultbrowser() {
        echo "Safari"
        echo "Google Chrome"
        echo "Microsoft Edge"
        echo "Brave Browser"
    }

    local result="$(_defaultbrowser_parse_browsers)"
    assert_contains "$result" "Google Chrome" "Handles browser names with spaces"
    assert_contains "$result" "Microsoft Edge" "Handles Microsoft Edge"
    assert_contains "$result" "Brave Browser" "Handles Brave Browser"
}

# Test 7: Only asterisk marked browser
test_parse_only_asterisk_browser() {
    defaultbrowser() { echo "* Safari"; }
    local result="$(_defaultbrowser_parse_browsers)"

    assert_equal "Safari" "$result" "Single browser with asterisk is cleaned"
}

# Test 8: No asterisk in list
test_parse_no_asterisk() {
    defaultbrowser() {
        echo "Safari"
        echo "Firefox"
        echo "Google Chrome"
    }

    local result="$(_defaultbrowser_parse_browsers)"
    assert_contains "$result" "Safari" "Contains Safari when no asterisk"
    assert_contains "$result" "Firefox" "Contains Firefox when no asterisk"
    assert_contains "$result" "Google Chrome" "Contains Google Chrome when no asterisk"
}

# Test 9: Error handling (command not found)
test_parse_command_error() {
    defaultbrowser() { return 1; }
    local result="$(_defaultbrowser_parse_browsers)"

    assert_equal "" "$result" "Handle command error gracefully"
}

# Test 10: Mixed formatting
test_parse_mixed_formatting() {
    defaultbrowser() {
        echo "Safari"
        echo "  Firefox"
        echo "* Google Chrome"
        echo "    Microsoft Edge  "
    }

    local result="$(_defaultbrowser_parse_browsers)"
    local expected="Safari
Firefox
Google Chrome
Microsoft Edge"

    assert_equal "$expected" "$result" "Handle mixed formatting correctly"
}

# Run all tests
test_parse_browsers
test_parse_empty_list
test_parse_single_browser
test_parse_whitespace
test_parse_with_asterisk
test_parse_browser_names_with_spaces
test_parse_only_asterisk_browser
test_parse_no_asterisk
test_parse_command_error
test_parse_mixed_formatting

# Print summary
print_summary
exit $?
