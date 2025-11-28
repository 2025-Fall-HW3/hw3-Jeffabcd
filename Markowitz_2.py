"""
Package Import
"""
import yfinance as yf
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import quantstats as qs
import gurobipy as gp
import warnings
import argparse
import sys

"""
Project Setup
"""
warnings.simplefilter(action="ignore", category=FutureWarning)

assets = [
    "SPY",
    "XLB",
    "XLC",
    "XLE",
    "XLF",
    "XLI",
    "XLK",
    "XLP",
    "XLRE",
    "XLU",
    "XLV",
    "XLY",
]

# Initialize Bdf and df
Bdf = pd.DataFrame()
for asset in assets:
    raw = yf.download(asset, start="2012-01-01", end="2024-04-01", auto_adjust = False)
    Bdf[asset] = raw['Adj Close']

df = Bdf.loc["2019-01-01":"2024-04-01"]

"""
Strategy Creation

Create your own strategy, you can add parameter but please remain "price" and "exclude" unchanged
"""


class MyPortfolio:
    """
    NOTE: You can modify the initialization function
    """

    def __init__(self, price, exclude, momentum_lookback=120, top_n=5):
        self.price = price
        self.returns = price.pct_change().fillna(0)
        self.exclude = exclude
        self.momentum_lookback = momentum_lookback
        self.top_n = top_n

    def calculate_weights(self):
        # Get the assets by excluding the specified column
        assets = self.price.columns[self.price.columns != self.exclude]

        # Calculate the portfolio weights
        self.portfolio_weights = pd.DataFrame(
            index=self.price.index, columns=self.price.columns
        )

        """
        TODO: Complete Task 4 Below
        """
        # Momentum Strategy with Proportional Weighting
        # Select top N performing sectors and weight them proportionally to their momentum
        n_assets = len(assets)
        
        for i in range(self.momentum_lookback + 1, len(self.price)):
            # Get historical returns for momentum calculation
            mom_returns = self.returns[assets].iloc[i - self.momentum_lookback : i]
            
            # Calculate momentum scores (cumulative returns over the period)
            momentum = (1 + mom_returns).prod() - 1
            
            # Select top N assets by momentum
            top_assets = momentum.nlargest(self.top_n).index
            
            # Weight proportionally to momentum score (not equal weight)
            top_momentum = momentum[top_assets]
            
            # Ensure all weights are positive by shifting if necessary
            if top_momentum.min() < 0:
                top_momentum = top_momentum - top_momentum.min() + 0.01
            
            # Normalize to sum to 1
            weights = top_momentum / top_momentum.sum()
            
            # Assign weights
            for asset in assets:
                if asset in top_assets:
                    self.portfolio_weights.loc[self.price.index[i], asset] = weights[asset]
                else:
                    self.portfolio_weights.loc[self.price.index[i], asset] = 0.0
        
        # Set excluded asset (SPY) to 0
        self.portfolio_weights[self.exclude] = 0
        """
        TODO: Complete Task 4 Above
        """

        self.portfolio_weights.ffill(inplace=True)
        self.portfolio_weights.fillna(0, inplace=True)

    def calculate_portfolio_returns(self):
        # Ensure weights are calculated
        if not hasattr(self, "portfolio_weights"):
            self.calculate_weights()

        # Calculate the portfolio returns
        self.portfolio_returns = self.returns.copy()
        assets = self.price.columns[self.price.columns != self.exclude]
        self.portfolio_returns["Portfolio"] = (
            self.portfolio_returns[assets]
            .mul(self.portfolio_weights[assets])
            .sum(axis=1)
        )

    def get_results(self):
        # Ensure portfolio returns are calculated
        if not hasattr(self, "portfolio_returns"):
            self.calculate_portfolio_returns()

        return self.portfolio_weights, self.portfolio_returns


if __name__ == "__main__":
    # Import grading system (protected file in GitHub Classroom)
    from grader_2 import AssignmentJudge
    
    parser = argparse.ArgumentParser(
        description="Introduction to Fintech Assignment 3 Part 12"
    )

    parser.add_argument(
        "--score",
        action="append",
        help="Score for assignment",
    )

    parser.add_argument(
        "--allocation",
        action="append",
        help="Allocation for asset",
    )

    parser.add_argument(
        "--performance",
        action="append",
        help="Performance for portfolio",
    )

    parser.add_argument(
        "--report", action="append", help="Report for evaluation metric"
    )

    parser.add_argument(
        "--cumulative", action="append", help="Cumulative product result"
    )

    args = parser.parse_args()

    judge = AssignmentJudge()
    
    # All grading logic is protected in grader_2.py
    judge.run_grading(args)
