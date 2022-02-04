package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func inputParse(x string) []int {
	file, err := os.Open(x)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)

	var inputSlice []int
	var inputInt int
	for scanner.Scan() {
		inputInt, _ = strconv.Atoi(scanner.Text())
		inputSlice = append(inputSlice, inputInt)
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return inputSlice

}
func main() {
	input := inputParse("advent.Input")

	fmt.Println(partOne(input))
}

func partOne(input []int) int {
	var count int
	for i := 0; i < len(input)-1; i++ {
		if input[i] < input[i+1] {
			count++
		}
	}
	return count
}
