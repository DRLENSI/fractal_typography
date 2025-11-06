# GPU Parity Drift Test Script

This script automates the process of diagnosing GPU parity drift in the Unified Fractal Framework (UFF). It compares the computational outputs from GPU and CPU parity runs and reports the percentage of drift for key metrics.

## Usage

To use the script, you first need to generate the parity files using the `fsv` CLI:

1.  **Run FSV Parity with GPU (Default):**

    ```bash
    fsv parity --seed 42 --out parity_gpu.parquet
    ```

2.  **Run FSV Parity with CPU Forced:**

    ```bash
    fsv parity --seed 42 --no-gpu --out parity_cpu.parquet
    ```

Once you have the `parity_gpu.parquet` and `parity_cpu.parquet` files, you can run the test script:

```bash
python test_gpu_parity.py --gpu-parity-file parity_gpu.parquet --cpu-parity-file parity_cpu.parquet
```

### Optional Arguments

*   `--drift-threshold`: Set a custom drift threshold. The default is `3.0`%.

    ```bash
    python test_gpu_parity.py --gpu-parity-file parity_gpu.parquet --cpu-parity-file parity_cpu.parquet --drift-threshold 5.0
    ```

## Interpreting the Output

The script will output the drift percentage for each metric and the maximum drift observed. If the maximum drift exceeds the specified threshold, the script will exit with an error, recommending that you lock to CPU execution for production workloads.

### Example Success Output

```
GPU Parity Drift Percentages:
  D_box: 1.2345%
  hurst: 2.3456%
  dfa_alpha: 0.1234%

Max Drift: 2.3456%

Success: Maximum drift of 2.3456% is within the acceptable threshold of 3.0%.
```

### Example Error Output

```
GPU Parity Drift Percentages:
  D_box: 4.5678%
  hurst: 2.3456%
  dfa_alpha: 1.2345%

Max Drift: 4.5678%

Error: Maximum drift of 4.5678% exceeds the threshold of 3.0%.
It is recommended to lock to CPU execution for production workloads.
```
