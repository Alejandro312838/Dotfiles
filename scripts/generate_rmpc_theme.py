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
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    default_album_art_path: None,
    draw_borders: false,
    show_song_table_header: false,
    symbols: (song: "🎵", dir: "📁", playlist: "🎼", marker: "\\u{{e0b0}}"),
    layout: Split(
        direction: Vertical,
        panes: [
            (
                pane: Pane(Header),
                size: "1",
            ),
            (
                pane: Pane(TabContent),
                size: "100%",
            ),
            (
                pane: Pane(ProgressBar),
                size: "1",
            ),
        ],
    ),
    progress_bar: (
        symbols: ["", "", "⭘", " ", " "],
        track_style: (bg: "{special['background']}"),
        elapsed_style: (fg: "{c['color2']}", bg: "{special['background']}"),
        thumb_style: (fg: "{c['color2']}", bg: "{special['background']}"),
    ),
    scrollbar: (
        symbols: ["│", "█", "▲", "▼"],
        track_style: (),
        ends_style: (),
        thumb_style: (fg: "{c['color6']}"),
    ),
    browser_column_widths: [20, 38, 42],
    text_color: "{special['foreground']}",
    background_color: "{special['background']}",
    header_background_color: "{special['background']}",
    modal_background_color: None,
    modal_backdrop: false,
    tab_bar: (active_style: (fg: "black", bg: "{c['color2']}", modifiers: "Bold"), inactive_style: ()),
    borders_style: (fg: "{c['color7']}"),
    highlighted_item_style: (fg: "{c['color1']}", modifiers: "Bold"),
    current_item_style: (fg: "black", bg: "{c['color6']}", modifiers: "Bold"),
    highlight_border_style: (fg: "{c['color6']}"),
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
            prop: (kind: Property(Title), style: (fg: "{c['color3']}"), default: (kind: Text("Unknown"))),
            width: "50%",
        ),
    ],
    header: (
        rows: [
            (
                left: [
                    (kind: Text("["), style: (fg: "{special['foreground']}", modifiers: "Bold")),
                    (kind: Property(Status(State)), style: (fg: "{special['foreground']}", modifiers: "Bold")),
                    (kind: Text("]"), style: (fg: "{special['foreground']}", modifiers: "Bold"))
                ],
                center: [
                    (kind: Property(Song(Artist)), style: (fg: "{c['color3']}", modifiers: "Bold"),
                        default: (kind: Text("Unknown"), style: (fg: "{c['color3']}", modifiers: "Bold"))
                    ),
                    (kind: Text(" - ")),
                    (kind: Property(Song(Title)), style: (fg: "{c['color1']}", modifiers: "Bold"),
                        default: (kind: Text("No Song"), style: (fg: "{c['color1']}", modifiers: "Bold"))
                    )
                ],
                right: [
                    (kind: Text("Vol: "), style: (fg: "{special['foreground']}", modifiers: "Bold")),
                    (kind: Property(Status(Volume)), style: (fg: "{special['foreground']}", modifiers: "Bold")),
                    (kind: Text("% "), style: (fg: "{special['foreground']}", modifiers: "Bold"))
                ]
            )
        ],
    ),
)
"""

RMPC_THEME.write_text(theme)

