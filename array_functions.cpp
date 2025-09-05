#include <iostream>
#include <iomanip>
#include <vector>
using namespace std;

// Function declarations (DO NOT CHANGE)
void displayArray(vector<int> arr, int size);
int findSum(vector<int> arr, int size);
double findAverage(vector<int> arr, int size);
int findMaximum(vector<int> arr, int size);
int findMinimum(vector<int> arr, int size);

// Function to display array elements
void displayArray(vector<int> arr, int size) {
    cout << "Array: {";
    //write your code here
    cout << "}" << endl;
}

// Function to find sum of all array elements
int findSum(vector<int> arr, int size) {
  //write your code here
}

// Function to find average of array elements
double findAverage(vector<int> arr, int size) {
    if (size == 0) {
        return 0.0;
    }
    //write your code here
}

// Function to find maximum element in array
int findMaximum(vector<int> arr, int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    
    //write your code here
}

// Function to find minimum element in array
int findMinimum(vector<int> arr, int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    
    //write your code here
}

//DO NOT CHANGE
int main() {
    int SIZE;
    cout << "Enter size of array: ";
    cin >> SIZE;
    vector<int> numbers(SIZE);
    cout << "Enter " << SIZE << " elements:\n";
    for (int i = 0; i < SIZE; i++) {
        cin >> numbers[i];
    }
    
    // Display the test array
    displayArray(numbers, SIZE);
    cout << "Array size: " << SIZE << " elements" << endl;
    // Calculate and display sum
    int sum = findSum(numbers, SIZE);
    cout << "Sum of elements: " << sum << endl;
    
    // Calculate and display average
    double average = findAverage(numbers, SIZE);
    cout << "Average of elements: " << fixed << setprecision(2) << average << endl;
    
    // Find and display maximum
    int maximum = findMaximum(numbers, SIZE);
    cout << "Maximum element: " << maximum << endl;
    
    // Find and display minimum
    int minimum = findMinimum(numbers, SIZE);
    cout << "Minimum element: " << minimum << endl;
    
    return 0;
}
