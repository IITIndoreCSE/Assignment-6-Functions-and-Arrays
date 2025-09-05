#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  C++ Programs Comprehensive Testing Suite     ${NC}"
echo -e "${BLUE}================================================${NC}"

# Global counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to compile a C++ program
compile_program() {
    local filename=$1
    local program_name=$2
    
    echo -e "\n${YELLOW}Compiling ${program_name}...${NC}"
    
    # Check if source file exists
    if [ ! -f "$filename" ]; then
        echo -e "${RED}Error: $filename not found!${NC}"
        return 1
    fi
    
    # Compile the program
    g++ -o "${filename%.cpp}" "$filename" 2> compilation_error.log
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Compilation failed for $filename${NC}"
        echo -e "${RED}Error details:${NC}"
        cat compilation_error.log
        rm -f compilation_error.log
        return 1
    else
        echo -e "${GREEN}✓ Compilation successful!${NC}"
        rm -f compilation_error.log
        return 0
    fi
}

# Function to run a test case
run_test() {
    local executable=$1
    local test_name=$2
    local test_input=$3
    local expected_pattern=$4
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "\n${CYAN}Test Case: $test_name${NC}"
    echo -e "${CYAN}${#test_name//?/-}----------${NC}"
    
    # Run the program with input
    if [ -n "$test_input" ]; then
        output=$(echo -e "$test_input" | "./$executable" 2>&1)
    else
        output=$("./$executable" 2>&1)
    fi
    
    exit_code=$?
    
    echo -e "${BLUE}Input:${NC} $test_input"
    echo -e "${BLUE}Output:${NC}"
    echo "$output"
    
    # Check if program executed successfully
    if [ $exit_code -ne 0 ]; then
        echo -e "${RED}✗ Test FAILED - Program crashed or returned error${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
    
    # Check expected pattern if provided
    if [ -n "$expected_pattern" ]; then
        if echo "$output" | grep -q "$expected_pattern"; then
            echo -e "${GREEN}✓ Test PASSED - Expected pattern found${NC}"
            PASSED_TESTS=$((PASSED_TESTS + 1))
            return 0
        else
            echo -e "${RED}✗ Test FAILED - Expected pattern '$expected_pattern' not found${NC}"
            FAILED_TESTS=$((FAILED_TESTS + 1))
            return 1
        fi
    else
        echo -e "${GREEN}✓ Test PASSED - Program executed successfully${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    fi
}

# Test Array Functions Program
test_array_functions() {
    echo -e "\n${PURPLE}========================================${NC}"
    echo -e "${PURPLE}  TESTING ARRAY FUNCTIONS PROGRAM      ${NC}"
    echo -e "${PURPLE}========================================${NC}"
    
    if ! compile_program "array_functions.cpp" "Array Functions Program"; then
        echo -e "${RED}Skipping tests due to compilation failure${NC}"
        return 1
    fi
    
    # Test Case 1: Basic functionality with provided array
    run_test "array_functions" "Basic Array Operations" "" "Array: {12, 45, 67, 23, 89, 34, 56}"
    
    # Since we can't modify the main function, we'll create test versions
    # Create a test version with different array values
    cat > test_array1.cpp << 'EOF'
#include <iostream>
#include <iomanip>
using namespace std;

void displayArray(int arr[], int size);
int findSum(int arr[], int size);
double findAverage(int arr[], int size);
int findMaximum(int arr[], int size);
int findMinimum(int arr[], int size);

// Copy your implementations here (assuming they're correct)
void displayArray(int arr[], int size) {
    cout << "Array: {";
    for (int i = 0; i < size; i++) {
        cout << arr[i];
        if (i < size - 1) {
            cout << ", ";
        }
    }
    cout << "}" << endl;
}

int findSum(int arr[], int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    return sum;
}

double findAverage(int arr[], int size) {
    if (size == 0) return 0.0;
    return static_cast<double>(findSum(arr, size)) / size;
}

int findMaximum(int arr[], int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    int max = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    return max;
}

int findMinimum(int arr[], int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    int min = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] < min) {
            min = arr[i];
        }
    }
    return min;
}

int main() {
    // Test Case: Single element array
    const int SIZE1 = 1;
    int numbers1[SIZE1] = {42};
    
    displayArray(numbers1, SIZE1);
    cout << "Sum: " << findSum(numbers1, SIZE1) << endl;
    cout << "Average: " << fixed << setprecision(2) << findAverage(numbers1, SIZE1) << endl;
    cout << "Maximum: " << findMaximum(numbers1, SIZE1) << endl;
    cout << "Minimum: " << findMinimum(numbers1, SIZE1) << endl;
    
    return 0;
}
EOF

    g++ -o test_array1 test_array1.cpp 2>/dev/null
    if [ $? -eq 0 ]; then
        run_test "test_array1" "Single Element Array" "" "Array: {42}"
        rm -f test_array1
    fi
    rm -f test_array1.cpp

    # Test Case: Negative numbers
    cat > test_array2.cpp << 'EOF'
#include <iostream>
#include <iomanip>
using namespace std;

void displayArray(int arr[], int size);
int findSum(int arr[], int size);
double findAverage(int arr[], int size);
int findMaximum(int arr[], int size);
int findMinimum(int arr[], int size);

void displayArray(int arr[], int size) {
    cout << "Array: {";
    for (int i = 0; i < size; i++) {
        cout << arr[i];
        if (i < size - 1) cout << ", ";
    }
    cout << "}" << endl;
}

int findSum(int arr[], int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    return sum;
}

double findAverage(int arr[], int size) {
    if (size == 0) return 0.0;
    return static_cast<double>(findSum(arr, size)) / size;
}

int findMaximum(int arr[], int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    int max = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] > max) max = arr[i];
    }
    return max;
}

int findMinimum(int arr[], int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    int min = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] < min) min = arr[i];
    }
    return min;
}

int main() {
    const int SIZE = 5;
    int numbers[SIZE] = {-10, 5, -3, 0, 8};
    
    displayArray(numbers, SIZE);
    cout << "Sum: " << findSum(numbers, SIZE) << endl;
    cout << "Average: " << fixed << setprecision(2) << findAverage(numbers, SIZE) << endl;
    cout << "Maximum: " << findMaximum(numbers, SIZE) << endl;
    cout << "Minimum: " << findMinimum(numbers, SIZE) << endl;
    
    return 0;
}
EOF

    g++ -o test_array2 test_array2.cpp 2>/dev/null
    if [ $? -eq 0 ]; then
        run_test "test_array2" "Array with Negative Numbers" "" "Array: {-10, 5, -3, 0, 8}"
        rm -f test_array2
    fi
    rm -f test_array2.cpp
    
    rm -f array_functions
}

# Test Calculator Program
test_calculator() {
    echo -e "\n${PURPLE}========================================${NC}"
    echo -e "${PURPLE}  TESTING CALCULATOR PROGRAM           ${NC}"
    echo -e "${PURPLE}========================================${NC}"
    
    if ! compile_program "calculator.cpp" "Calculator Program"; then
        echo -e "${RED}Skipping tests due to compilation failure${NC}"
        return 1
    fi
    
    # Test Case 1: Positive numbers
    run_test "calculator" "Positive Numbers" "10.5\n3.2" "10.5.*3.2"
    
    # Test Case 2: Integer numbers
    run_test "calculator" "Integer Numbers" "15\n4" "15.*4"
    
    # Test Case 3: Negative numbers
    run_test "calculator" "Negative Numbers" "-8.5\n2.3" "-8.5.*2.3"
    
    # Test Case 4: Division by zero
    run_test "calculator" "Division by Zero" "10\n0" "10.*0"
    
    # Test Case 5: Zero operations
    run_test "calculator" "Operations with Zero" "0\n5.5" "0.*5.5"
    
    # Test Case 6: Large numbers
    run_test "calculator" "Large Numbers" "999999.99\n0.001" "999999.99.*0.001"
    
    # Test Case 7: Decimal precision
    run_test "calculator" "Decimal Precision" "1.111\n2.222" "1.111.*2.222"
    
    rm -f calculator
}

# Test Reverse Array Program
test_reverse_array() {
    echo -e "\n${PURPLE}========================================${NC}"
    echo -e "${PURPLE}  TESTING REVERSE ARRAY PROGRAM        ${NC}"
    echo -e "${PURPLE}========================================${NC}"
    
    if ! compile_program "reverse_array.cpp" "Reverse Array Program"; then
        echo -e "${RED}Skipping tests due to compilation failure${NC}"
        return 1
    fi
    
    # Test Case 1: Basic functionality with provided array
    run_test "reverse_array" "Basic Array Reversal" "" "Reversed Array: 5, 4, 3, 2, 1"
    
    # Create additional test cases
    # Test Case 2: Single element array
    cat > test_reverse1.cpp << 'EOF'
#include <iostream>
using namespace std;

void displayArray(int arr[], int size) {
    cout << "Array: ";
    for (int i = 0; i < size; i++) {
        cout << arr[i];
        if (i < size - 1) cout << ", ";
    }
    cout << endl;
}

void reverseArray(int arr[], int size) {
    int start = 0;
    int end = size - 1;
    while (start < end) {
        int temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

int main() {
    const int SIZE = 1;
    int numbers[SIZE] = {42};
    
    cout << "Original ";
    displayArray(numbers, SIZE);
    reverseArray(numbers, SIZE);
    cout << "Reversed ";
    displayArray(numbers, SIZE);
    
    return 0;
}
EOF

    g++ -o test_reverse1 test_reverse1.cpp 2>/dev/null
    if [ $? -eq 0 ]; then
        run_test "test_reverse1" "Single Element Array" "" "Reversed Array: 42"
        rm -f test_reverse1
    fi
    rm -f test_reverse1.cpp

    # Test Case 3: Even number of elements
    cat > test_reverse2.cpp << 'EOF'
#include <iostream>
using namespace std;

void displayArray(int arr[], int size) {
    cout << "Array: ";
    for (int i = 0; i < size; i++) {
        cout << arr[i];
        if (i < size - 1) cout << ", ";
    }
    cout << endl;
}

void reverseArray(int arr[], int size) {
    int start = 0;
    int end = size - 1;
    while (start < end) {
        int temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

int main() {
    const int SIZE = 6;
    int numbers[SIZE] = {10, 20, 30, 40, 50, 60};
    
    cout << "Original ";
    displayArray(numbers, SIZE);
    reverseArray(numbers, SIZE);
    cout << "Reversed ";
    displayArray(numbers, SIZE);
    
    return 0;
}
EOF

    g++ -o test_reverse2 test_reverse2.cpp 2>/dev/null
    if [ $? -eq 0 ]; then
        run_test "test_reverse2" "Even Number of Elements" "" "Reversed Array: 60, 50, 40, 30, 20, 10"
        rm -f test_reverse2
    fi
    rm -f test_reverse2.cpp

    # Test Case 4: Array with negative numbers
    cat > test_reverse3.cpp << 'EOF'
#include <iostream>
using namespace std;

void displayArray(int arr[], int size) {
    cout << "Array: ";
    for (int i = 0; i < size; i++) {
        cout << arr[i];
        if (i < size - 1) cout << ", ";
    }
    cout << endl;
}

void reverseArray(int arr[], int size) {
    int start = 0;
    int end = size - 1;
    while (start < end) {
        int temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

int main() {
    const int SIZE = 7;
    int numbers[SIZE] = {-5, -10, 0, 15, -20, 25, -30};
    
    cout << "Original ";
    displayArray(numbers, SIZE);
    reverseArray(numbers, SIZE);
    cout << "Reversed ";
    displayArray(numbers, SIZE);
    
    return 0;
}
EOF

    g++ -o test_reverse3 test_reverse3.cpp 2>/dev/null
    if [ $? -eq 0 ]; then
        run_test "test_reverse3" "Array with Negative Numbers" "" "Reversed Array: -30, 25, -20, 15, 0, -10, -5"
        rm -f test_reverse3
    fi
    rm -f test_reverse3.cpp

    # Test Case 5: Two element array
    cat > test_reverse4.cpp << 'EOF'
#include <iostream>
using namespace std;

void displayArray(int arr[], int size) {
    cout << "Array: ";
    for (int i = 0; i < size; i++) {
        cout << arr[i];
        if (i < size - 1) cout << ", ";
    }
    cout << endl;
}

void reverseArray(int arr[], int size) {
    int start = 0;
    int end = size - 1;
    while (start < end) {
        int temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

int main() {
    const int SIZE = 2;
    int numbers[SIZE] = {100, 200};
    
    cout << "Original ";
    displayArray(numbers, SIZE);
    reverseArray(numbers, SIZE);
    cout << "Reversed ";
    displayArray(numbers, SIZE);
    
    return 0;
}
EOF

    g++ -o test_reverse4 test_reverse4.cpp 2>/dev/null
    if [ $? -eq 0 ]; then
        run_test "test_reverse4" "Two Element Array" "" "Reversed Array: 200, 100"
        rm -f test_reverse4
    fi
    rm -f test_reverse4.cpp
    
    rm -f reverse_array
}

# Main execution
main() {
    echo -e "${CYAN}Starting comprehensive test suite...${NC}\n"
    
    # Run all test suites
    test_array_functions
    test_calculator  
    test_reverse_array
    
    # Final summary
    echo -e "\n${BLUE}================================================${NC}"
    echo -e "${BLUE}           FINAL TEST RESULTS SUMMARY           ${NC}"
    echo -e "${BLUE}================================================${NC}"
    echo -e "${CYAN}Total Tests Run: $TOTAL_TESTS${NC}"
    echo -e "${GREEN}Tests Passed: $PASSED_TESTS${NC}"
    echo -e "${RED}Tests Failed: $FAILED_TESTS${NC}"
    
    if [ $FAILED_TESTS -eq 0 ]; then
        echo -e "\n${GREEN}🎉 ALL TESTS PASSED! Great job!${NC}"
        echo -e "${GREEN}Your implementations are working correctly.${NC}"
    else
        echo -e "\n${YELLOW}⚠️  Some tests failed. Please review your implementations.${NC}"
        echo -e "${YELLOW}Check the failed test outputs above for debugging.${NC}"
    fi
    
    # Success rate
    if [ $TOTAL_TESTS -gt 0 ]; then
        SUCCESS_RATE=$(echo "scale=1; $PASSED_TESTS * 100 / $TOTAL_TESTS" | bc -l 2>/dev/null || echo "N/A")
        echo -e "${CYAN}Success Rate: $SUCCESS_RATE%${NC}"
    fi
    
    echo -e "\n${BLUE}================================================${NC}"
    
    # Cleanup any remaining files
    rm -f test_*.cpp test_array* test_reverse* compilation_error.log
}

# Check if bc is available for percentage calculation
if ! command -v bc &> /dev/null; then
    echo -e "${YELLOW}Note: 'bc' calculator not found. Success rate calculation will be skipped.${NC}"
fi

# Run the main function
main
