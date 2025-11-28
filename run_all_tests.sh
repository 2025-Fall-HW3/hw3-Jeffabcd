#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

# Function to print test status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASSED${NC}"
    else
        echo -e "${RED}✗ FAILED${NC}"
    fi
}

# Activate virtual environment
echo -e "${YELLOW}Activating virtual environment...${NC}"
source venv/bin/activate

# Check if activation was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to activate virtual environment!${NC}"
    exit 1
fi

# Initialize counters
total_tests=0
passed_tests=0

# ====================
# PART 1: Markowitz.py
# ====================

print_header "PART 1: Portfolio Theory Tests (Markowitz.py)"

# Test 1: Equal Weight Portfolio
echo -e "${YELLOW}Test 1: Equal Weight Portfolio${NC}"
python Markowitz.py --score eqw
status=$?
total_tests=$((total_tests + 1))
if [ $status -eq 0 ]; then
    passed_tests=$((passed_tests + 1))
fi
print_status $status

# Test 2: Risk Parity Portfolio
echo -e "${YELLOW}Test 2: Risk Parity Portfolio${NC}"
python Markowitz.py --score rp
status=$?
total_tests=$((total_tests + 1))
if [ $status -eq 0 ]; then
    passed_tests=$((passed_tests + 1))
fi
print_status $status

# Test 3: Mean Variance Portfolio
echo -e "${YELLOW}Test 3: Mean Variance Portfolio${NC}"
python Markowitz.py --score mv
status=$?
total_tests=$((total_tests + 1))
if [ $status -eq 0 ]; then
    passed_tests=$((passed_tests + 1))
fi
print_status $status

# Test 4: All Part 1 Problems
echo -e "${YELLOW}Test 4: All Part 1 Problems Combined${NC}"
python Markowitz.py --score all
status=$?
total_tests=$((total_tests + 1))
if [ $status -eq 0 ]; then
    passed_tests=$((passed_tests + 1))
fi
print_status $status

# ====================
# PART 2: Markowitz_2.py
# ====================

print_header "PART 2: Custom Portfolio Tests (Markowitz_2.py)"

# Test 5: Sharpe Ratio > 1
echo -e "${YELLOW}Test 5: Sharpe Ratio > 1 (2019-2024)${NC}"
python Markowitz_2.py --score one
status=$?
total_tests=$((total_tests + 1))
if [ $status -eq 0 ]; then
    passed_tests=$((passed_tests + 1))
fi
print_status $status

# Test 6: Sharpe Ratio > SPY
echo -e "${YELLOW}Test 6: Sharpe Ratio > SPY (2012-2024)${NC}"
python Markowitz_2.py --score spy
status=$?
total_tests=$((total_tests + 1))
if [ $status -eq 0 ]; then
    passed_tests=$((passed_tests + 1))
fi
print_status $status

# Test 7: All Part 2 Problems
echo -e "${YELLOW}Test 7: All Part 2 Problems Combined${NC}"
python Markowitz_2.py --score all
status=$?
total_tests=$((total_tests + 1))
if [ $status -eq 0 ]; then
    passed_tests=$((passed_tests + 1))
fi
print_status $status

# ====================
# Summary
# ====================

print_header "TEST SUMMARY"
echo -e "Total Tests: ${BLUE}$total_tests${NC}"
echo -e "Passed: ${GREEN}$passed_tests${NC}"
echo -e "Failed: ${RED}$((total_tests - passed_tests))${NC}"

if [ $passed_tests -eq $total_tests ]; then
    echo ""
    echo -e "${GREEN}🎉 ALL TESTS PASSED! 🎉${NC}"
    echo -e "${GREEN}Your homework is ready for submission!${NC}"
    exit 0
else
    echo ""
    echo -e "${YELLOW}⚠ Some tests failed. Please review the output above.${NC}"
    exit 1
fi

