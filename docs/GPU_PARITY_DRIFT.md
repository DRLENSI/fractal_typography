# GPU Parity Drift and CPU Enforcement

This document outlines the procedures for diagnosing GPU parity drift and forcing CPU execution within the Unified Fractal Framework (UFF). These steps are critical for ensuring computational consistency and reliability, especially in production environments.

## 1. Diagnosing GPU Parity Drift

To diagnose GPU parity drift, we compare the computational outputs of the GPU and CPU. This is achieved by running the `fsv` parity suite with and without GPU acceleration and then comparing the results.

### Steps:

1.  **Run FSV Parity with GPU (Default):**
    ```bash
    fsv parity --seed 42 --out parity_gpu.parquet
    ```

2.  **Run FSV Parity with CPU Forced:**
    ```bash
    fsv parity --seed 42 --no-gpu --out parity_cpu.parquet
    ```

3.  **Compare CPU vs. GPU Outputs:**
    The following Python script can be used to compare the generated `.parquet` files and quantify the drift:

    ```python
    import pandas as pd

    # Load the parity data
    gpu_parity = pd.read_parquet("parity_gpu.parquet")
    cpu_parity = pd.read_parquet("parity_cpu.parquet")

    # Define the metrics to compare
    metrics = ["D_box", "hurst", "dfa_alpha"]

    # Compute the mean parity drift for each metric
    drift = {m: (abs(cpu_parity[m] - gpu_parity[m]).mean() / cpu_parity[m].mean()) * 100 for m in metrics}

    print("GPU Parity Drift Percentages:", drift)
    print("Max Drift:", max(drift.values()))
    ```

### Interpretation:

A drift of **more than 3%** in any metric is considered above the acceptable parity threshold. If the drift exceeds this value, it is recommended to lock the framework to CPU execution for production workloads to ensure consistent and reliable results.

## 2. Forcing CPU Execution

There are two primary methods to force the Unified Fractal Framework to use only the CPU for computation.

### A. Environment Variable (Recommended)

This method is recommended for production environments, such as APIs or daemon processes.

```bash
export FSV_BACKEND=cpu
fsv parity --seed 42 --out parity_cpu.parquet
```

The `fsv` engine will detect the `FSV_BACKEND` environment variable and force all computations to the CPU, bypassing any GPU-specific code paths.

### B. CLI Argument

For single invocations or testing, the `--no-gpu` argument can be used.

```bash
fsv parity --seed 42 --no-gpu --out parity_cpu.parquet
fsv compute --in data.csv --no-gpu --out metrics_cpu.parquet
```

This argument disables GPU acceleration for that specific command.

## Summary Table

| Action | CLI Command Example |
| :--- | :--- |
| Run GPU Parity | `fsv parity --seed 42 --out parity_gpu.parquet` |
| Run CPU Parity | `fsv parity --seed 42 --no-gpu --out parity_cpu.parquet` |
| Compare CPU vs. GPU | Python script (see above) |
| Force CPU (Global) | `export FSV_BACKEND=cpu; fsv ...` |
| Force CPU (Single Command) | `fsv ... --no-gpu` |

If drift exceeds the allowed 3% threshold, it is crucial to lock the execution to the CPU path before proceeding with further validation or deployment.
