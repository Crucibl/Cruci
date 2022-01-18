package reverse

import (
	"strings"
)

func Reverse(s string) string {
	splitS := strings.Split(s, "")

	var reverseSplitS []string

	for _, letter := range splitS {
		reverseSplitS = append([]string{string(letter)}, reverseSplitS...)

	}

	return strings.Join(reverseSplitS, "")

}

// pass in a string into function. variable placeholder for string. go is strictly typed.
// floats are decimal numbers
// go want to tell type that you want come out
// for compilation purposes
// string is a list of characters
// variables are placeholders for data containers you want to change
// [[]] slice of string in some languages referred to as array
// In Go Capital letter means you are exporting
//  as long as index is less than count I run the for loop
// set variable usually use indexes to maneuver your for loops
// range iterates over elements in  a variety of data structures
// range on arrays and slices provides both the index and value for each array
// Use append to add to a slice or array
// take each letter and append then I return
// Join concatenates the elements your variable to create a single string
