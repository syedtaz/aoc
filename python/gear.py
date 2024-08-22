from typing import NamedTuple

Position = NamedTuple("Position", [("x", int), ("y", int)])


def symbol_positions(line: str, i: int) -> list[Position]:
    results: list[Position] = []

    for j, s in enumerate(line):
        if not s.isalnum():
            results.append(Position(i, j))

    return results
