package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
)

func main() {
	base := os.Args[1]

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		path := scanner.Text()
		formatted, _ := filepath.Rel(base, path)
		fmt.Println(formatted)
	}
}
