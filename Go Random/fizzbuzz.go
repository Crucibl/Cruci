package main

import "fmt"

func fizzBuzz() {
	countTo := 100

	for i := 0; i <= countTo; i++ {
		if i%15 == 0 {
			fmt.Println("Fizz Buzz")
		} else if i%5 == 0 {
			fmt.Println("Buzz")
		} else if i%3 == 0 {
			fmt.Println("Fizz")
		} else {
			fmt.Println(i)
		}

	}
}

func main() {
	fizzBuzz()
}
