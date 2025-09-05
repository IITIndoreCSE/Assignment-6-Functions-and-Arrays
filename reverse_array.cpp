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
    int size;
    cout << "Enter size of the array: ";
    cin >> size;

    int numbers[size];
    cout << "Enter " << size << " elements: ";
    for (int i = 0; i < size; i++) {
        cin >> numbers[i];
    }
    
    cout << "Original Array: ";
    displayArray(numbers, size);
    
    reverseArray(numbers, size);
    
    cout << "Reversed Array: ";
    displayArray(numbers, size);
    
    return 0;
}
