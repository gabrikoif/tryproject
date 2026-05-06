#include "stack.h"
#include "platform_utils.h"
#include "terminal.h"

int main()
{
    srand(time(NULL));
    int size = 5;
    Node *list = create_list(size);
    int rows, cols;
    init(&rows, &cols);

    // Initialized.

    int box_h = 3;
    int box_w = 10;
    int count = list_size(list);
    int row = (rows - box_h * count) / 2;
    int col = (cols - box_w) / 2;
    Node *pulledList = create_list(0);
    draw_stack(row, col, box_h, box_w, list);

    int ch = 0;
    do
    {
        // int size = list_size(list);
        if (ch == KEY_RESIZE)
        {
            getmaxyx(stdscr, rows, cols);
            row = (rows - box_h * count) / 2;
            col = (cols - box_w) / 2;
        }

        switch (ch)
        {
        case KEY_UP:
            int pulled;
            if (pull(&list, &pulled))
            {
                break;
            }
            push(&pulledList, pulled);
            break;
        case KEY_DOWN:
            int top;
            if (pull(&pulledList, &top))
            {
                break;
            }
            push(&list, top);
            break;
        case KEY_RIGHT:
            col += 2;
            break;
        case KEY_LEFT:
            col -= 2;
            break;
        default:
            break;
        }
        draw_stack(row, col, box_h, box_w, list);
    } while ((ch = getch()) != 'q');
    // Finish
    free_list(list);
    free_list(pulledList);
    endwin();
    return 0;
}
