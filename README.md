# Leetcode Daily Challenge, in Many Languages

![java](https://img.shields.io/badge/Java-21.0.4--tem-blue.svg)
![c++](https://img.shields.io/badge/C++-gcc--13.2.0-purple.svg)
![kotlin](https://img.shields.io/badge/Kotlin-1.9.0-blue.svg)
![go](https://img.shields.io/badge/Go-1.23.2-cyan.svg)
![rust](https://img.shields.io/badge/Rust-1.81.0-orange.svg)
![elixir](https://img.shields.io/badge/Elixir-1.17.3--OTP25-purple.svg)

## How to run
To comiple and run the program, execute the following command, in this example we are running java solution for date 2024-10-01 challenge:
```bash
make java date=2024-10-01
```
This will do:
1. Traversing all the solution inside the given date folder, in case there are more than one solution, it will execute each solution in order.
1. Compile the file using input from `input.txt`
1. Output from the program will be written to `output.txt`.
1. If the output is different from the expected output file `expected.txt`, it will print the error and exit.
