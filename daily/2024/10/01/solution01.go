package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func canArrange(arr []int, k int) bool {
	remainder := make([]int, k)
	for _, num := range arr {
		modu := (num%k + k) % k
		remainder[modu]++
	}

	if remainder[0]%2 != 0 {
		return false
	}

	for i := 1; i < k; i++ {
		if remainder[i] != remainder[k-i] {
			return false
		}
	}
	return true
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		arrStr := strings.ReplaceAll(line, "[", "")
		arrStr = strings.ReplaceAll(arrStr, "]", "")
		arr := []int{}

		for _, str := range strings.Split(arrStr, ",") {
			num, err := strconv.Atoi(strings.TrimSpace(str))
			if err != nil {
				fmt.Println("Error parsing integer:", err)
				return
			}
			arr = append(arr, num)
		}

		if !scanner.Scan() {
			fmt.Println("Expected integer input for k")
			return
		}
		k, err := strconv.Atoi(scanner.Text())
		if err != nil {
			fmt.Println("Error parsing integer k:", err)
			return
		}

		result := canArrange(arr, k)
		fmt.Println(result)
	}
}
