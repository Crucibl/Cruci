package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func inputParse(x string) []string {
	file, err := os.Open(x)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)

	var inputSlice []string
	for scanner.Scan() {
		inputSlice = append(inputSlice, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return inputSlice

}
func main() {
	input := inputParse("AdventInputDay2")

	fmt.Println(partOne(input))
}

func partOne(directions []string) int {
	var directionSplit []string
	horizontalPosition := 0
	depth := 0
	var orientation string
	var distance int

	for i := 0; i < len(directions); i++ {
		directionSplit = strings.Split(directions[i], " ")

		fmt.Println(directionSplit)

		orientation = directionSplit[0]
		distance, _ = strconv.Atoi(directionSplit[1])

		if orientation == "forward" {
			horizontalPosition += distance
		} else if orientation == "up" {
			depth -= distance
		} else {
			depth += distance
		}
	}
	return horizontalPosition * depth
}
