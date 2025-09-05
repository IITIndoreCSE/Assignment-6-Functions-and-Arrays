#include <iostream>
#include <iomanip>
using namespace std;

// Function declarations (DO NOT CHANGE)
void displayArray(int arr[], int size);
int findSum(int arr[], int size);
double findAverage(int arr[], int size);
int findMaximum(int arr[], int size);
int findMinimum(int arr[], int size);

// Function to display array elements
void displayArray(int arr[], int size) {
    cout << "Array: {";
    //write your code here
    cout << "}" << endl;
}

// Function to find sum of all array elements
int findSum(int arr[], int size) {
  //write your code here
}

// Function to find average of array elements
double findAverage(int arr[], int size) {
    //write your code here
}

// Function to find maximum element in array
int findMaximum(int arr[], int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    
    //write your code here
}

// Function to find minimum element in array
int findMinimum(int arr[], int size) {
    if (size == 0) {
        cout << "Error: Empty array!" << endl;
        return 0;
    }
    
    //write your code here
}

//DO NOT CHANGE
int main() {
    const int SIZE = 7;
    int numbers[SIZE] = {12, 45, 67, 23, 89, 34, 56};
    
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
