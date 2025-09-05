#include <iostream>
#include <vector>
using namespace std;

// Function declarations (DO NOT CHANGE)
void displayArray(const vector<int>& arr);
void reverseArray(vector<int>& arr);

// Function to display array elements (DO NOT CHANGE)
void displayArray(const vector<int>& arr) {
    cout << "Array: ";
    for (size_t i = 0; i < arr.size(); i++) {
        cout << arr[i];
        if (i < arr.size() - 1) cout << ", ";
    }
    cout << endl;
}

// Function to reverse array in-place (without creating any new array)
void reverseArray(vector<int>& arr) {
    // Write your code here
}

//(DO NOT CHANGE)
int main() {
    int size;
    cout << "Enter size of the array: ";
    cin >> size;

    if (size <= 0) {
        cout << "Invalid array size!" << endl;
        return 1;
    }

    vector<int> numbers(size);
    cout << "Enter " << size << " elements: ";
    for (int i = 0; i < size; i++) {
        cin >> numbers[i];
    }
    
    cout << "Original Array: ";
    displayArray(numbers);
    
    reverseArray(numbers);
    
    cout << "Reversed Array: ";
    displayArray(numbers);
    
    return 0;
}
