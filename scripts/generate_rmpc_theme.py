#!/usr/bin/env python3
import json
from pathlib import Path

WAL_COLORS = Path.home() / ".cache" / "wal" / "colors.json"
RMPC_THEME = Path.home() / ".config" / "rmpc" / "themes" / "pywal.ron"

with open(WAL_COLORS) as f:
    data = json.load(f)

c = data["colors"]
special = data["special"]

theme = f"""#![enable(implicit_some)]
(
    text_color: "{special['foreground']}",
    background_color: "{special['background']}",
    header_background_color: "{special['background']}",
    current_item_style: (fg: "black", bg: "{c['color14']}", modifiers: "Bold"),
    highlighted_item_style: (fg: "{c['color2']}", modifiers: "Bold"),
    highlight_border_style: (fg: "{c['color14']}"),
    progress_bar: (
        track_style: (bg: "{special['background']}"),
        elapsed_style: (fg: "{c['color2']}", bg: "{special['background']}"),
        thumb_style: (fg: "{c['color2']}", bg: "{special['background']}")
    ),
    tab_bar: (
        active_style: (fg: "black", bg: "{c['color2']}", modifiers: "Bold"),
        inactive_style: ()
    ),
    scrollbar: (
        thumb_style: (fg: "{c['color6']}")
    ),
    song_table_format: [
        (
            prop: (kind: Property(Artist), style: (fg: "{c['color6']}"), default: (kind: Text("Unknown"))),
            width: "50%",
            alignment: Right,
        ),
        (
            prop: (kind: Text("-"), style: (fg: "{c['color6']}"), default: (kind: Text("Unknown"))),
            width: "1",
            alignment: Center,
        ),
        (
            prop: (kind: Property(Title), style: (fg: "{c['color5']}"), default: (kind: Text("Unknown"))),
            width: "50%",
        )
    ],
)
"""

RMPC_THEME.write_text(theme)

