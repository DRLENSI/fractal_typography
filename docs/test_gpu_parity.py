#!/usr/bin/env python

import argparse
import pandas as pd
import sys

def main():
    """Main function to run the GPU parity drift test."""
    parser = argparse.ArgumentParser(description="Diagnose GPU parity drift for the Unified Fractal Framework.")
    parser.add_argument("--gpu-parity-file", required=True, help="Path to the GPU parity data file (e.g., parity_gpu.parquet)")
    parser.add_argument("--cpu-parity-file", required=True, help="Path to the CPU parity data file (e.g., parity_cpu.parquet)")
    parser.add_argument("--drift-threshold", type=float, default=3.0, help="The maximum acceptable drift percentage.")
    args = parser.parse_args()

    try:
        gpu_parity = pd.read_parquet(args.gpu_parity_file)
        cpu_parity = pd.read_parquet(args.cpu_parity_file)
    except Exception as e:
        print(f"Error reading parity files: {e}", file=sys.stderr)
        sys.exit(1)

    metrics = ["D_box", "hurst", "dfa_alpha"]
    missing_metrics = [m for m in metrics if m not in gpu_parity.columns or m not in cpu_parity.columns]
    if missing_metrics:
        print(f"Error: The following metrics are missing from the parity files: {missing_metrics}", file=sys.stderr)
        sys.exit(1)

    drift = {m: (abs(cpu_parity[m] - gpu_parity[m]).mean() / cpu_parity[m].mean()) * 100 for m in metrics}

    print("GPU Parity Drift Percentages:")
    for metric, drift_value in drift.items():
        print(f"  {metric}: {drift_value:.4f}%")

    max_drift = max(drift.values())
    print(f"\nMax Drift: {max_drift:.4f}%")

    if max_drift > args.drift_threshold:
        print(f"\nError: Maximum drift of {max_drift:.4f}% exceeds the threshold of {args.drift_threshold}%.", file=sys.stderr)
        print("It is recommended to lock to CPU execution for production workloads.", file=sys.stderr)
        sys.exit(1)
    else:
        print(f"\nSuccess: Maximum drift of {max_drift:.4f}% is within the acceptable threshold of {args.drift_threshold}%.")

if __name__ == "__main__":
    main()
