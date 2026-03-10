#!/usr/bin/env python3
# generate-png-from-ascii-braille.py
# Renders a braille ASCII art text file into a centered PNG image.
#
# Usage:
#   python3 ascii/generate-png-from-ascii-braille.py
#
# Requirements:
#   pip install -r ascii/requirements.txt

import os

from PIL import Image, ImageDraw

# ─── Config ──────────────────────────────────────────────────────────

CANVAS_W = 1920
CANVAS_H = 1080
CELL_W = 9  # width of one character cell in pixels
CELL_H = 16  # height of one character cell in pixels
DOT_R = 1.6  # radius of each braille dot

BG_COLOR = "#202020"
FG_COLOR = "#dfbf8e"

# Line range in hydra_ascii.txt (0-indexed, end exclusive)
# Lines 0-10  → small hydra
# Lines 12-33 → large hydra
LINE_START = 12
LINE_END = 34

DOTFILES = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
INPUT = os.path.join(DOTFILES, "ascii", "hydra_ascii.txt")
OUTPUT = os.path.join(DOTFILES, ".config", "ghostty", "hydra.png")

# ─── Braille dot layout ───────────────────────────────────────────────
# Each braille character encodes 8 dots in a 2-col x 4-row grid.
# Bit → (col, row): 0→(0,0) 1→(0,1) 2→(0,2) 3→(1,0)
#                   4→(1,1) 5→(1,2) 6→(0,3) 7→(1,3)

DOT_POS = [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (0, 3), (1, 3)]

# ─── Helpers ─────────────────────────────────────────────────────────


def hex_to_rgb(hex_color):
    h = hex_color.lstrip("#")
    return tuple(int(h[i : i + 2], 16) for i in (0, 2, 4))


def render(lines, canvas_w, canvas_h, cell_w, cell_h, dot_r, bg, fg):
    art_w = max(len(line) for line in lines) * cell_w
    art_h = len(lines) * cell_h
    off_x = (canvas_w - art_w) // 2
    off_y = (canvas_h - art_h) // 2

    img = Image.new("RGB", (canvas_w, canvas_h), bg)
    draw = ImageDraw.Draw(img)

    for row_i, line in enumerate(lines):
        for col_i, ch in enumerate(line):
            cp = ord(ch)
            if 0x2800 <= cp <= 0x28FF:
                bits = cp - 0x2800
                cx = off_x + col_i * cell_w
                cy = off_y + row_i * cell_h
                for bit, (dx, dy) in enumerate(DOT_POS):
                    if bits & (1 << bit):
                        x = cx + dx * (cell_w // 2) + cell_w // 4
                        y = cy + dy * (cell_h // 4) + cell_h // 8
                        draw.ellipse(
                            [x - dot_r, y - dot_r, x + dot_r, y + dot_r], fill=fg
                        )
    return img


# ─── Main ─────────────────────────────────────────────────────────────

if __name__ == "__main__":
    content = open(INPUT).read()
    lines = content.split("\n")[LINE_START:LINE_END]

    bg = hex_to_rgb(BG_COLOR)
    fg = hex_to_rgb(FG_COLOR)

    img = render(lines, CANVAS_W, CANVAS_H, CELL_W, CELL_H, DOT_R, bg, fg)
    img.save(OUTPUT)
    print(f"Saved {CANVAS_W}x{CANVAS_H} → {OUTPUT}")
