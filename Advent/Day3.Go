package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"math"
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
	input := inputParse("AdventInputDay3")
	
	result := dayOne(input)

	fmt.Println(result)
}
func dayOne(list []string) float64 {
	var gammaString string
	var epsilonString string
	for bit := 0; bit < len(list[0]); bit++ {
		zeroes := 0
		ones := 0
		for item := 0; item < len(list); item++ {
			switch string(list[item][bit]) {
			case "0":
				zeroes++
			case "1":
				ones++
				
			}
		}

		if zeroes > ones {
			gammaString += "0"
			epsilonString += "1"
		} else {
			gammaString += "1"
			epsilonString += "0"
		}
		fmt.Println("Zeros: %v - Ones: %v\n", zeroes, ones)
		}
		gamma := binaryConv(gammaString)
		epsilon := binaryConv(epsilonString)
		
		return gamma * epsilon
	}

	func binaryConv(binaryString string) float64 {
		var num int
		var decimal float64
		i := 0
		for digit := len(binaryString) - 1; digit >= 0; digit-- {
			num, _ = strconv.Atoi(string(binaryString[digit]))
			decimal += float64(num) * math.Pow(2, float64(i))
			i++
		}
		return decimal
	}