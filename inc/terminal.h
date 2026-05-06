#pragma once

#include "stack.h"
#define BG COLOR_BLACK
#define STACK_COUNT 3

void init(int* rows, int* cols);
void draw_box(int row, int col, int height, int width, int color, int pair); 
void draw_stack(int start_row, int col, int box_height, int box_width, Node* head);
int shift_focus(int focus, int direction);
