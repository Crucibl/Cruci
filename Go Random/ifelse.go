package main

import "fmt"

func main() {
	name := "Bob"

	if name == "Alice" {
		fmt.Printf("One for %v, one for me.\n", name)
	} else if name == "Bob" {
		fmt.Println("Do something else")
	} else {
		fmt.Println("Do something completely different")
	}

}
