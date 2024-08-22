#include <stdint.h>
#include <stdlib.h>
#include <string.h>

typedef struct game {
  uint64_t id;
  uint64_t red;
  uint64_t green;
  uint64_t blue;
} game;

uint64_t capability(game *g) {
  if (g->red <= 12 && g->green <= 13 && g->blue <= 14) {
    return g->id;
  }
  return 0;
}

uint64_t power(game *g) { return g->red * g->blue * g->green; }

uint64_t extract_id(char *chunk) {
  char *token;

  // We only care about the second value
  for (int i = 0; i < 2; i++) {
    token = strsep(&chunk, " ");
  }

  return atoi(token);
}

void parse_round(char *line, int *rgb) {
  int red, blue, green;
  char *token, *components;

  while ((token = strsep(&line, ","))) {
    // First value is the number
    components = strsep(&token, " ");
    int value = atoi(components);

    // Second value is the color
    components = strsep(&token, " ");
    if (strcmp(components, "blue") == 0) {
      blue = value;
    } else if (strcmp(components, "green") == 0) {
      green = value;
    } else if (strcmp(components, "red") == 0) {
      red = value;
    } else {
      exit(EXIT_FAILURE);
    }
  }

  rgb[0] = red;
  rgb[1] = green;
  rgb[2] = blue;
  return;
}

game *parse(char *line) {
  char *game_sep, *rest, *round;
  int rgb[3];
  int red, green, blue;

  game *g = malloc(sizeof(game));
  game_sep = strsep(&line, ":");
  rest = strsep(&line, ":");

  for (int j = 0; j < 3; j++) {
    round = strsep(&rest, ";");
    parse_round(round, rgb);
    red = rgb[0] >= red ? rgb[0] : red;
    green = rgb[1] >= green ? rgb[1] : green;
    blue = rgb[2] >= blue ? rgb[2] : blue;
  }

  free(rest);
  free(round);
  free(game_sep);
  return g;
}