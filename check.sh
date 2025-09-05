#!/usr/bin/env bash
# Unified test runner for Lab 6 (calculator.cpp, array_functions.cpp, reverse_array.cpp)
# Total tests: 14 (edge-case-focused)
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
  # Normalize CRLF
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
# array_functions.cpp (4 tests)
########################################
run_test array_functions "7\n12 45 67 23 89 34 56" \
$'Enter size of array: Enter 7 elements:\nArray: {12, 45, 67, 23, 89, 34, 56}\nArray size: 7 elements\nSum of elements: 326\nAverage of elements: 46.57\nMaximum element: 89\nMinimum element: 12'

run_test array_functions "1\n5" \
$'Enter size of array: Enter 1 elements:\nArray: {5}\nArray size: 1 elements\nSum of elements: 5\nAverage of elements: 5.00\nMaximum element: 5\nMinimum element: 5'

run_test array_functions "2\n10 -10" \
$'Enter size of array: Enter 2 elements:\nArray: {10, -10}\nArray size: 2 elements\nSum of elements: 0\nAverage of elements: 0.00\nMaximum element: 10\nMinimum element: -10'

run_test array_functions "0\n" \
$'Enter size of array: Enter 0 elements:\nArray: {}\nArray size: 0 elements\nSum of elements: 0\nAverage of elements: 0.00\nError: Empty array!\nMaximum element: 0\nError: Empty array!\nMinimum element: 0'

########################################
# reverse_array.cpp (4 tests)
########################################
run_test reverse_array "5\n1 2 3 4 5" \
$'Enter size of the array: Enter 5 elements: Original Array: Array: 1, 2, 3, 4, 5\nReversed Array: Array: 5, 4, 3, 2, 1'

run_test reverse_array "4\n10 20 30 40" \
$'Enter size of the array: Enter 4 elements: Original Array: Array: 10, 20, 30, 40\nReversed Array: Array: 40, 30, 20, 10'

run_test reverse_array "1\n7" \
$'Enter size of the array: Enter 1 elements: Original Array: Array: 7\nReversed Array: Array: 7'

run_test reverse_array "0" \
$'Enter size of the array: Invalid array size!'

########################################
# calculator.cpp (6 tests)
########################################
run_test calculator "12\n4" \
$'Enter first number: Enter second number: \nCalculator Results\nNumbers: 12 and 4\nAddition: 16\nSubtraction: 8\nMultiplication: 48\nDivision: 3'

run_test calculator "-5\n3" \
$'Enter first number: Enter second number: \nCalculator Results\nNumbers: -5 and 3\nAddition: -2\nSubtraction: -8\nMultiplication: -15\nDivision: -1.66667'

run_test calculator "-7\n-2" \
$'Enter first number: Enter second number: \nCalculator Results\nNumbers: -7 and -2\nAddition: -9\nSubtraction: -5\nMultiplication: 14\nDivision: 3.5'

run_test calculator "0\n10" \
$'Enter first number: Enter second number: \nCalculator Results\nNumbers: 0 and 10\nAddition: 10\nSubtraction: -10\nMultiplication: 0\nDivision: 0'

run_test calculator "10\n0" \
$'Enter first number: Enter second number: \nCalculator Results\nNumbers: 10 and 0\nAddition: 10\nSubtraction: 10\nMultiplication: 0\nDivision: inf'

run_test calculator "3.5\n1.5" \
$'Enter first number: Enter second number: \nCalculator Results\nNumbers: 3.5 and 1.5\nAddition: 5\nSubtraction: 2\nMultiplication: 5.25\nDivision: 2.33333'

########################################
echo
echo "Summary: Passed=$pass Failed=$fail Total=$total"
[[ $fail -eq 0 ]] && exit 0 || exit 1
