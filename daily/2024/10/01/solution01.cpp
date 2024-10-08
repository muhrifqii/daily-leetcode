#include <stdio.h>
#include <vector>
#include <algorithm>
#include <sstream>
#include <string>
#include <iostream>

using namespace std;

class Solution {
public:
    bool canArrange(vector<int>& arr, int k) {
        vector<int> remainder(k, 0);

        for (int num : arr) {
            int modu = ((num % k) + k) % k;
            remainder[modu]++;
        }

        if (remainder[0] % 2 != 0) {
            return false;
        }

        for (int i = 1; i < k; i++) {
            if (remainder[i] != remainder[k - i]) {
                return false;
            }
        }
        return true;
    }
};

int main() {
    string line;
    Solution s;

    while (getline(cin, line)) {
        line.erase(remove(line.begin(), line.end(), '['), line.end());
        line.erase(remove(line.begin(), line.end(), ']'), line.end());

        vector<int> arr;
        stringstream ss(line);
        string temp;

        // Split the string by commas and convert to integers
        while (getline(ss, temp, ',')) {
            arr.push_back(stoi(temp));
        }

        // Read the value of k from the next line
        int k;
        cin >> k;
        cin.ignore(); // To consume the newline character after reading k

        // Calculate and print the result
        bool result = s.canArrange(arr, k);
        cout << (result ? "true" : "false") << endl;
    }

    return 0;
}
