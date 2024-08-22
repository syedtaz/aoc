package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type game struct {
	id    int
	red   int
	green int
	blue  int
}

func (g *game) capability() int {
	if g.red <= 12 && g.green <= 13 && g.blue <= 14 {
		return g.id
	}
	return 0
}

func (g *game) power() int {
	return g.red * g.green * g.blue
}

func parse_round(s string) (int, int, int) {
	var red, blue, green, v int
	var err error

	for _, chunk := range strings.Split(s, ",") {
		components := strings.Split(strings.TrimSpace(chunk), " ")
		if v, err = strconv.Atoi(components[0]); err != nil {
			panic("can't parse")
		}

		switch components[1] {
		case "blue":
			blue = v
		case "green":
			green = v
		case "red":
			red = v
		default:
			panic("invalid colour")
		}
	}

	return red, green, blue
}

func extract_id(chunk string) int {
	var id int
	var err error

	if id, err = strconv.Atoi(strings.Split(chunk, " ")[1]); err != nil {
		panic("can't parse")
	}

	return id
}

func parse(line string) game {
	csplit := strings.Split(line, ":")
	id := extract_id(csplit[0])
	var red, green, blue int

	for _, s := range strings.Split(csplit[1], ";") {
		r, g, b := parse_round(s)
		red = max(red, r)
		green = max(green, g)
		blue = max(blue, b)
	}

	return game{id: id, red: red, green: green, blue: blue}
}

func main() {
	var result int
	var power int

	filename := os.Args[1]
	file, err := os.Open(filename)

	if err != nil {
		panic("can't find file")
	}

	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		game := parse(line)
		result += game.capability()
		power += game.power()
	}

	fmt.Printf("results=%d, powers=%d\n", result, power)
}
