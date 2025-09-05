#!/usr/bin/env bash
# Unified test runner for Lab 6 (calculator.cpp, array_functions.cpp, reverse_array.cpp)

set -u

CXX=${CXX:-g++}
CXXFLAGS="-std=c++17 -O2 -Wall -Wextra -Werror -pedantic"

sources=(calculator.cpp array_functions.cpp reverse_array.cpp)
binaries=(calculator array_functions reverse_array)

compile() {
  local src="$1" out="$2"
  echo "Compiling $src -> $out"
  $CXX $CXXFLAGS "$src" -o "$out"
}

pass=0
fail=0
total=0

run_test() {
  local exe="$1" input="$2" expected="$3"
  ((total++))
  local output
  output="$(echo -e "$input" | "./$exe")"
  # Normalize CRLF just in case
  output="$(echo -n "$output" | tr -d '\r')"
  if [[ "$output" == "$expected" ]]; then
    echo "✓ $exe <$input> => PASS"
    ((pass++))
  else
    echo "✗ $exe <$input> => FAIL"
    echo "   expected:"
    echo "$expected"
    echo "   got:"
    echo "$output"
    ((fail++))
  fi
}

# --- Compile all sources ---
for i in "${!sources[@]}"; do
  compile "${sources[$i]}" "${binaries[$i]}" || { echo "Compilation failed for ${sources[$i]}"; exit 1; }
done

echo
echo "== Running tests =="

########################################
# Tests for array_functions.cpp (4 cases)
########################################
# Default array {12,45,67,23,89,34,56}
run_test array_functions "" \
$'Array: {12, 45, 67, 23, 89, 34, 56}\nArray size: 7 elements\nSum of elements: 326\nAverage of elements: 46.57\nMaximum element: 89\nMinimum element: 12'

# Single element {5}
run_test array_functions "" \
$'Array: {5}\nArray size: 1 elements\nSum of elements: 5\nAverage of elements: 5.00\nMaximum element: 5\nMinimum element: 5'

# Two elements {10, -10}
run_test array_functions "" \
$'Array: {10, -10}\nArray size: 2 elements\nSum of elements: 0\nAverage of elements: 0.00\nMaximum element: 10\nMinimum element: -10'

# Empty array
run_test array_functions "" \
$'Array: {}\nArray size: 0 elements\nSum of elements: 0\nAverage of elements: 0.00\nError: Empty array!\nMaximum element: 0\nError: Empty array!\nMinimum element: 0'

########################################
# Tests for calculator.cpp (8 cases)
########################################
run_test calculator "12\n4\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: 12 and 4\n=========================================\nAddition: 12 + 4 = 16\nSubtraction: 12 - 4 = 8\nMultiplication: 12 * 4 = 48\nDivision: 12 / 4 = 3\n========================================='

run_test calculator "-5\n3\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: -5 and 3\n=========================================\nAddition: -5 + 3 = -2\nSubtraction: -5 - 3 = -8\nMultiplication: -5 * 3 = -15\nDivision: -5 / 3 = -1.66667\n========================================='

run_test calculator "-7\n-2\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: -7 and -2\n=========================================\nAddition: -7 + -2 = -9\nSubtraction: -7 - -2 = -5\nMultiplication: -7 * -2 = 14\nDivision: -7 / -2 = 3.5\n========================================='

run_test calculator "0\n10\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: 0 and 10\n=========================================\nAddition: 0 + 10 = 10\nSubtraction: 0 - 10 = -10\nMultiplication: 0 * 10 = 0\nDivision: 0 / 10 = 0\n========================================='

run_test calculator "10\n0\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: 10 and 0\n=========================================\nAddition: 10 + 0 = 10\nSubtraction: 10 - 0 = 10\nMultiplication: 10 * 0 = 0\nError: Division by zero!\nDivision: 10 / 0 = 0\n========================================='

run_test calculator "3.5\n1.5\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: 3.5 and 1.5\n=========================================\nAddition: 3.5 + 1.5 = 5\nSubtraction: 3.5 - 1.5 = 2\nMultiplication: 3.5 * 1.5 = 5.25\nDivision: 3.5 / 1.5 = 2.33333\n========================================='

run_test calculator "1000000\n1000000\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: 1000000 and 1000000\n=========================================\nAddition: 1000000 + 1000000 = 2000000\nSubtraction: 1000000 - 1000000 = 0\nMultiplication: 1000000 * 1000000 = 1e+12\nDivision: 1000000 / 1000000 = 1\n========================================='

run_test calculator "7\n1\n" \
$'Enter first number: Enter second number: \n========== CALCULATOR RESULTS ==========\nNumbers: 7 and 1\n=========================================\nAddition: 7 + 1 = 8\nSubtraction: 7 - 1 = 6\nMultiplication: 7 * 1 = 7\nDivision: 7 / 1 = 7\n========================================='

########################################
# Tests for reverse_array.cpp (2 cases)
########################################
run_test reverse_array "" \
$'========== ARRAY REVERSAL PROGRAM ==========\nOriginal Array: 1, 2, 3, 4, 5\nReversed Array: 5, 4, 3, 2, 1'

run_test reverse_array "" \
$'========== ARRAY REVERSAL PROGRAM ==========\nOriginal Array: 10, 20, 30, 40\nReversed Array: 40, 30, 20, 10'

########################################
echo
echo "Summary: Passed=$pass Failed=$fail Total=$total"
[[ $fail -eq 0 ]] && exit 0 || exit 1
