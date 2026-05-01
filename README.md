# Learning how to work with ncurses

## What is ncurses?

ncurses (new curses) is a programming library for creating textual user interfaces (TUIs) that work across a wide variety of terminals. It is written in a way that attempts to optimize the commands that are sent to the terminal, to reduce the latency experienced when updating the displayed content.

### tree

``` txt
ncursesLearn
├── inc
│   ├── platform_utils.h
│   ├── terminal.h
│   └── ui.h
├── Makefile
├── README.md
└── src
    ├── main.c
    ├── terminal.c
    └── ui.c
```
