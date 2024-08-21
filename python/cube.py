from dataclasses import dataclass
import sys


@dataclass
class Game:
    id: int
    red: int
    green: int
    blue: int


def capability(g: Game) -> int:
    return g.id if g.red <= 12 and g.green <= 13 and g.blue <= 14 else 0

def power(g: Game) -> int:
    return g.red * g.green * g.blue

def parse_round(s: str) -> tuple[int, int, int]:
    red, green, blue = 0, 0, 0

    for chunk in s.split(","):
        [v, k] = chunk.strip().split(" ")
        match k:
            case "blue":
                blue = int(v)
            case "green":
                green = int(v)
            case "red":
                red = int(v)
            case _:
                raise Exception

    return (red, green, blue)


def parse(line: str) -> Game:
    [g, rest] = line.split(":")
    [_, id] = g.split(" ")
    red, green, blue = 0, 0, 0

    for s in rest.split(";"):
        r, g, b = parse_round(s)
        red = max(red, r)
        green = max(green, g)
        blue = max(blue, b)

    return Game(int(id), red, green, blue)


def main() -> None:
    filename = sys.argv[1]
    with open(filename) as f:
        lines = [x.strip() for x in f.readlines()]
        results = sum([capability(parse(x)) for x in lines])
        powers = sum([power(parse(x)) for x in lines])
        print(f"{results=}, {powers=}")


if __name__ == "__main__":
    main()
