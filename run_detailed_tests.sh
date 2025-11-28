#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

# Function to print subsection
print_subsection() {
    echo ""
    echo -e "${CYAN}>>> $1${NC}"
}

# Activate virtual environment
echo -e "${YELLOW}Activating virtual environment...${NC}"
source venv/bin/activate

if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to activate virtual environment!${NC}"
    exit 1
fi

# ====================
# PART 1: Markowitz.py
# ====================

print_header "PART 1: PORTFOLIO THEORY (Markowitz.py)"

# Equal Weight Portfolio
print_subsection "1. Equal Weight Portfolio"
echo "Scoring:"
python Markowitz.py --score eqw
echo ""
echo "Allocation:"
python Markowitz.py --allocation eqw

# Risk Parity Portfolio
print_subsection "2. Risk Parity Portfolio"
echo "Scoring:"
python Markowitz.py --score rp
echo ""
echo "Allocation:"
python Markowitz.py --allocation rp

# Mean Variance Portfolio
print_subsection "3. Mean Variance Portfolio"
echo "Scoring:"
python Markowitz.py --score mv
echo ""
echo "Allocation:"
python Markowitz.py --allocation mv
echo ""
echo "Performance:"
python Markowitz.py --performance mv
echo ""
echo "Evaluation Metrics:"
python Markowitz.py --report mv

# All Part 1
print_subsection "4. All Part 1 Combined"
python Markowitz.py --score all

# ====================
# PART 2: Markowitz_2.py
# ====================

print_header "PART 2: CUSTOM PORTFOLIO (Markowitz_2.py)"

# My Portfolio - Sharpe > 1
print_subsection "1. Sharpe Ratio > 1 (2019-2024)"
python Markowitz_2.py --score one

# My Portfolio - Sharpe > SPY
print_subsection "2. Sharpe Ratio > SPY (2012-2024)"
python Markowitz_2.py --score spy

# All Part 2
print_subsection "3. All Part 2 Combined"
python Markowitz_2.py --score all

# My Portfolio - Detailed Analysis
print_subsection "4. My Portfolio - Detailed Analysis"
echo "Allocation:"
python Markowitz_2.py --allocation mp
echo ""
echo "Performance:"
python Markowitz_2.py --performance mp
echo ""
echo "Evaluation Metrics:"
python Markowitz_2.py --report mp
echo ""
echo "Cumulative Results:"
python Markowitz_2.py --cumulative mp

# Big Portfolio - Detailed Analysis
print_subsection "5. Big Portfolio (2012-2024) - Detailed Analysis"
echo "Allocation:"
python Markowitz_2.py --allocation bmp
echo ""
echo "Performance:"
python Markowitz_2.py --performance bmp
echo ""
echo "Evaluation Metrics:"
python Markowitz_2.py --report bmp
echo ""
echo "Cumulative Results:"
python Markowitz_2.py --cumulative bmp

# ====================
# Final Summary
# ====================

print_header "TESTING COMPLETE"
echo -e "${GREEN}All tests have been executed!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review the output above for any errors"
echo "2. Check that all score tests passed"
echo "3. Commit and push your changes to GitHub"
echo ""
echo -e "${CYAN}To run a quick score check only, use:${NC}"
echo "  ./run_all_tests.sh"
echo ""

