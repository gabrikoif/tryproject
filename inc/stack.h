#pragma once
#include <stdlib.h>
#include <time.h>

typedef enum {
    MY_COLOR_RED,
    MY_COLOR_GREEN,
    MY_COLOR_BLUE,
    MY_COLOR_YELLOW,
    MY_COLOR_ORANGE,
    MY_COLOR_PURPLE,
    NUM_COLORS
} Color;

typedef struct Node
{
    int data;
    struct Node* next;
} Node;

Node* create_list(int size);
void free_list(Node* head);
void printlist(Node* head);
void push(Node** head, int val);
int pull(Node** head, int* top);
int list_size(Node* head);
