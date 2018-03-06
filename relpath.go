package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
)

func main() {
	base := os.Args[1]
	cwd, err := os.Getwd()
	if err != nil {
		os.Exit(1)
	}

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		path := filepath.Join(cwd, scanner.Text())
		formatted, err := filepath.Rel(base, path)
		if err != nil {
			continue
		}
		fmt.Println(formatted)
	}
}
