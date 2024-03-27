#!/usr/bin/env python3
import os
import re
import sys

import matplotlib.pyplot as plt

def plot_benchmark_results(home_dir):
    # Open the file
    filepath = os.path.join(home_dir, "result", "CINT2006.001.txt")
    with open(filepath, 'r') as f:
        content = f.read()

    # Use a regular expression to extract benchmark results
    pattern = r"(\d{3}\.\w+)\s+\d+\s+(\d+)\s+([\d\.]+)"
    results = re.findall(pattern, content)

    # Separate the results into names, run times, and rates
    names, run_times, rates = zip(*results)

    # Convert run times and rates to integers and floats
    run_times = list(map(int, run_times))
    rates = list(map(float, rates))

    # Create a bar chart for the run times
    plt.figure(figsize=(10, 5))
    plt.bar(names, run_times)
    plt.xlabel('Benchmark')
    plt.ylabel('Run Time')
    plt.title('Benchmark Run Times')
    plt.xticks(rotation=90)
    plt.tight_layout()
    plt.show()

    # Create a bar chart for the rates
    plt.figure(figsize=(10, 5))
    plt.bar(names, rates)
    plt.xlabel('Benchmark')
    plt.ylabel('Rate')
    plt.title('Benchmark Rates')
    plt.xticks(rotation=90)
    plt.tight_layout()
    plt.show()

# Call the function to plot the benchmark results
plot_benchmark_results(sys.argv[1])