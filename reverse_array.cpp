#include <iostream>
using namespace std;

// Function declarations (DO NOT CHANGE)
void displayArray(int arr[], int size);
void reverseArray(int arr[], int size);

// Function to display array elements (DO NOT CHANGE)
void displayArray(int arr[], int size) {
    cout << "Array: ";
    for (int i = 0; i < size; i++) {
        cout << arr[i];
        if (i < size - 1) cout << ", ";
    }
    cout << endl;
}

// Function to reverse array in-place (without creating any new array)
void reverseArray(int arr[], int size) {
    //Write your code here
  
}

//(DO NOT CHANGE)
int main() {
    const int SIZE = 5;
    int numbers[SIZE] = {1, 2, 3, 4, 5};
    
    cout << "========== ARRAY REVERSAL PROGRAM ==========" << endl;
    
    // Display original array
    cout << "Original ";
    displayArray(numbers, SIZE);
    
    // Reverse the array
    reverseArray(numbers, SIZE);
    
    // Display reversed array
    cout << "Reversed ";
    displayArray(numbers, SIZE);
    
    return 0;
}
