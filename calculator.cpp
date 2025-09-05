#include <iostream>
using namespace std;

// Function declarations/prototypes (DO NOT CHANGE)
double add(double a, double b);
double subtract(double a, double b);
double multiply(double a, double b);
double divide(double a, double b);

// Write the function to add two numbers



// Write the function to subtract two numbers



// Write the function to multiply two numbers



// Write the function to divide two numbers



//DO NOT CHANGE
int main() {
    double num1, num2;
   
    cout << "Enter first number: ";
    cin >> num1;
    cout << "Enter second number: ";
    cin >> num2;
    
    cout << "\nCalculator Results" << endl;
    cout << "Numbers: " << num1 << " and " << num2 << endl;
    
    cout << "Addition: " << add(num1, num2) << endl;
    cout << "Subtraction: " << subtract(num1, num2) << endl;
    cout << "Multiplication: " << multiply(num1, num2) << endl;
    cout << "Division: " << divide(num1, num2) << endl;
    
    return 0;
}
