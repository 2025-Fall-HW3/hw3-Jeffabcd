# Homework 3 Implementation Summary

## Completed Tasks

### Part 1: Portfolio Theory (70/70 points) ✓

#### 1. Equal Weight Portfolio (20/20 points) ✓
- **Implementation**: Each asset receives equal weight (1/n)
- **File**: `Markowitz.py` - `EqualWeightPortfolio` class
- **Test**: `python Markowitz.py --score eqw`

#### 2. Risk Parity Portfolio (20/20 points) ✓
- **Implementation**: Inverse volatility weighting with 50-day lookback
- **Formula**: w_i = (1/σ_i) / Σ(1/σ_j)
- **File**: `Markowitz.py` - `RiskParityPortfolio` class
- **Test**: `python Markowitz.py --score rp`

#### 3. Mean Variance Portfolio (30/30 points) ✓
- **Implementation**: Markowitz optimization using Gurobi
- **Objective**: maximize (μ'w - γ/2 * w'Σw)
- **Constraints**: Long-only (w ≥ 0), fully invested (Σw = 1)
- **File**: `Markowitz.py` - `MeanVariancePortfolio` class
- **Test**: `python Markowitz.py --score mv`

### Part 2: Custom Portfolio (15/30 points)

#### 4.1 Sharpe Ratio > 1.0 (2019-2024) (15/15 points) ✓
- **Implementation**: Momentum-based sector rotation
- **Strategy**: Select top 2 sectors by 100-day momentum, equal weight
- **Result**: Sharpe Ratio = 1.0311
- **Test**: `python Markowitz_2.py --score one`

#### 4.2 Sharpe Ratio > SPY (2012-2024) (0/15 points) ✗
- **Status**: Not achieved with current parameters
- **SPY Sharpe**: 0.8898
- **Portfolio Sharpe**: 0.8364
- **Test**: `python Markowitz_2.py --score spy`

## Current Score: 85/100 points

## Testing Scripts

Two shell scripts have been created for comprehensive testing:

### 1. Quick Test Script: `run_all_tests.sh`
```bash
./run_all_tests.sh
```
Runs all scoring tests and provides a summary.

### 2. Detailed Test Script: `run_detailed_tests.sh`
```bash
./run_detailed_tests.sh
```
Runs all tests including allocations, performance metrics, and reports.

## Implementation Details

### Markowitz.py

**Equal Weight Portfolio:**
- Simple 1/n allocation across all non-SPY assets
- No rebalancing logic needed

**Risk Parity Portfolio:**
- Calculates rolling 50-day volatility for each asset
- Weights inversely proportional to volatility
- Rebalances daily starting from day 51

**Mean Variance Portfolio:**
- Uses Gurobi optimizer for quadratic programming
- 50-day rolling window for expected returns and covariance
- Gamma parameter controls risk aversion (default: 0)

### Markowitz_2.py

**Custom Portfolio (MyPortfolio):**
- **Strategy**: Momentum-based sector rotation
- **Parameters**: 
  - `momentum_lookback = 100` days
  - `top_n = 2` sectors
- **Logic**:
  1. Calculate cumulative returns over past 100 days for each sector
  2. Select top 2 sectors with highest momentum
  3. Equal weight (50% each) among selected sectors
  4. Rebalance daily

## Performance Metrics

### Part 1 Strategies (2019-2024)
- Equal Weight: Sharpe ≈ 0.80
- Risk Parity: Sharpe ≈ 0.68
- Mean Variance: Sharpe ≈ 0.35

### Part 2 Custom Strategy
- **2019-2024**: Sharpe = 1.0311 ✓ (Goal: > 1.0)
- **2012-2024**: Sharpe = 0.8364 ✗ (Goal: > 0.8898)

## Notes for Improvement

To achieve the second goal (beating SPY on 2012-2024), consider:

1. **Different parameters for different periods**: Use conditional logic based on date
2. **More sophisticated momentum**: Combine multiple timeframes
3. **Risk management**: Add stop-loss or volatility targeting
4. **Factor combination**: Blend momentum with value or quality factors
5. **Dynamic allocation**: Adjust top_n based on market conditions

The current implementation successfully completes 85% of the assignment with all Part 1 problems solved perfectly and one of the two Part 2 goals achieved.


