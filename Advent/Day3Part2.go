package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
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
	CO2 := partTwo(input, "CO2")
	O2 := partTwo(input, "O2")

	fmt.Println(CO2)
	fmt.Println(O2)

}
func partTwo(list []string, rating string) float64 {
	filteredList := list

	for bit := 0; bit < len(filteredList[0]); bit++ {
		zeroes := 0
		ones := 0
		for item := 0; item < len(filteredList); item++ {
			if string(filteredList[item][bit]) == "0" {
				zeroes++
			} else {
				ones++

			}
		}

		if rating == "O2" {
			if zeroes > ones {
				filteredList = filter(filteredList, "0", bit)
			} else {
				filteredList = filter(filteredList, "1", bit)
			}
		} else {
			if zeroes > ones {
				filteredList = filter(filteredList, "1", bit)
			} else {
				filteredList = filter(filteredList, "0", bit)
			}
		}
	}
	result := binaryConv(filteredList[0])

	return result
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

func filter(list []string, criteria string, index int) []string {
	var filteredList []string
	for i := 0; i < len(list); i++ {
		if len(list) == 1 {
			filteredList = list
			break
		}
		if string(list[i][index]) == criteria {
			filteredList = append(filteredList, list[i])
		}
	}
	return filteredList
}
