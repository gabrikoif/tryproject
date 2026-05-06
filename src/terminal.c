#include "platform_utils.h"
#include "terminal.h"

void init(int *rows, int *cols)
{
    initscr();
    curs_set(0);
    start_color();
    cbreak();
    noecho();
    keypad(stdscr, TRUE);
    getmaxyx(stdscr, *rows, *cols);
}

void draw_box(int row, int col, int height, int width, int color, int pair)
{
    init_pair(pair, color, color);
    attron(COLOR_PAIR(pair));
    for (int i = row; i < row + height; i++)
        mvhline(i, col, ' ', width);
    attroff(COLOR_PAIR(pair));
}

void draw_stack(int start_row, int col, int box_height, int box_width, Node *head)
{
    clear();
    int i = 0;
    while (head != NULL)
    {
        int row = start_row + i * box_height;
        draw_box(row, col, box_height, box_width, head->data, 32 + i);
        head = head->next;
        i++;
    }
    refresh();
}

int shift_focus(int focus, int direction)
{
    // direction as a "boolean". right = 1. left = !right = 0.
    int maxIndex = STACK_COUNT - 1; // indexing starts at 0.
    if ((direction && focus == maxIndex) || (!direction && focus == 0))
    {
      return focus;
    }
    else if (direction) { focus++; }
    else { focus--; }
    return focus;
}
