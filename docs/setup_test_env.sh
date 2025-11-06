#!/bin/bash

# Setup Testing Environment for GPU Parity Drift Testing
# This script sets up the necessary environment for testing GPU parity drift in the Unified Fractal Framework

set -e

echo "=========================================="
echo "GPU Parity Drift Testing Environment Setup"
echo "=========================================="
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3 before continuing."
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "Error: pip3 is not installed. Please install pip3 before continuing."
    exit 1
fi

echo "✓ pip3 found"

# Create a virtual environment
echo ""
echo "Creating virtual environment..."
python3 -m venv venv_gpu_parity

echo "✓ Virtual environment created"

# Activate the virtual environment
echo ""
echo "Activating virtual environment..."
source venv_gpu_parity/bin/activate

echo "✓ Virtual environment activated"

# Install required packages
echo ""
echo "Installing required packages..."
pip install --upgrade pip
pip install pandas pyarrow

echo "✓ Required packages installed"

# Create test data directory
echo ""
echo "Creating test data directory..."
mkdir -p test_data

echo "✓ Test data directory created"

# Create a sample configuration file
echo ""
echo "Creating sample configuration file..."
cat > test_data/config.yaml <<EOF
# GPU Parity Drift Testing Configuration

# Drift threshold (percentage)
drift_threshold: 3.0

# Metrics to compare
metrics:
  - D_box
  - hurst
  - dfa_alpha

# Test seeds
seeds:
  - 42
  - 123
  - 456
  - 789
  - 1024

# Output directory
output_dir: test_data/results
EOF

echo "✓ Configuration file created at test_data/config.yaml"

# Create a results directory
echo ""
echo "Creating results directory..."
mkdir -p test_data/results

echo "✓ Results directory created"

# Create a README for the test environment
echo ""
echo "Creating test environment README..."
cat > test_data/README.md <<EOF
# GPU Parity Drift Testing Environment

This directory contains the testing environment for GPU parity drift testing in the Unified Fractal Framework.

## Directory Structure

\`\`\`
test_data/
├── config.yaml       # Configuration file for testing
├── results/          # Directory for test results
└── README.md         # This file
\`\`\`

## Usage

1. Activate the virtual environment:
   \`\`\`bash
   source venv_gpu_parity/bin/activate
   \`\`\`

2. Run GPU parity tests:
   \`\`\`bash
   fsv parity --seed 42 --out test_data/results/parity_gpu.parquet
   \`\`\`

3. Run CPU parity tests:
   \`\`\`bash
   fsv parity --seed 42 --no-gpu --out test_data/results/parity_cpu.parquet
   \`\`\`

4. Compare results:
   \`\`\`bash
   python ../test_gpu_parity.py --gpu-parity-file test_data/results/parity_gpu.parquet --cpu-parity-file test_data/results/parity_cpu.parquet
   \`\`\`

## Configuration

Edit \`config.yaml\` to customize:
- Drift threshold
- Metrics to compare
- Test seeds
- Output directory

## Notes

- Ensure the \`fsv\` CLI is installed and available in your PATH
- GPU support requires appropriate hardware and drivers
- CPU tests may take longer than GPU tests
EOF

echo "✓ Test environment README created"

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "To activate the virtual environment, run:"
echo "  source venv_gpu_parity/bin/activate"
echo ""
echo "To run tests, follow the instructions in test_data/README.md"
echo ""
