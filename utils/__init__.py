# system imports --------------------------------------------------------------------------------- #
import os


# methods ---------------------------------------------------------------------------------------- #
def print_heading(text):
    terminal_width = os.get_terminal_size().columns - (len(text) + 2)
    segment = "="
    left = "".join([segment for _ in range(terminal_width // 2)])
    right = "".join([segment for _ in range(terminal_width // 2)])

    if terminal_width % 2 != 0:
        right += segment

    print(f"{left} {text} {right}")

def print_subheading(text):
    terminal_width = os.get_terminal_size().columns - (len(text) + 2)
    segment = "-"
    left = "".join([segment for _ in range(terminal_width // 2)])
    right = "".join([segment for _ in range(terminal_width // 2)])

    if terminal_width % 2 != 0:
        right += segment

    print(f"{left} {text} {right}")
