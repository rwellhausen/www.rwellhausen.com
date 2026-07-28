# Attack of the Blobs — game art

Cartoon-style vector art for the video game *Attack of the Blobs*, drawn from
William's original pencil/crayon sketches (kept in `sketches/`).

## Assets

| File | What it is |
|------|------------|
| `cartoon-icons.svg` / `.png` | 2×2 sheet of game menu icons: red book, Shop sign, Earth (with dot eyes), crossed swords |
| `wind-blob.svg` / `.png` | Wind Blob — blue triangular tornado with clouds inside |
| `earth-blob.svg` / `.png` | Earth Blob — stepped pyramid of brown blocks |
| `volcano-blob.svg` / `.png` | Volcano Blob — erupting mountain |
| `firework-blob.svg` / `.png` | Firework Blob — sparkler burst (revision pending: new sketch coming) |
| `gem-blob.svg` / `.png` | Gem Blob — blue faceted crystal (approved, do not change) |
| `gold-blob.svg` / `.png` | Gold Blob — tilted gold bar (approved, do not change) |
| `cloth-blob.svg` / `.png` | Cloth Blob — red dish cloth with dark hem |
| `wave-blob.svg` / `.png` | Wave Blob — curling wave with foam |
| `moss-blob.svg` / `.png` | Moss Blob — mossy boulder with a sprout |
| `moon-blob.svg` / `.png` | Moon Blob — fat purple crescent, face on the wide part |
| `heart-blobs.svg` / `.png` | Heart Blobs — touching trio with emotions: happy, mad, sad |

SVGs are the editable masters (each icon/character is a named group; colors are
plain hex fills). PNGs are rendered at working size; character PNGs have
transparent backgrounds.

## Style rules

- Thick dark outlines (`#2b2340`), rounded joins
- Bright flat fills, minimal shading (one shine stripe max)
- Blobs get two dot eyes only — no mouths, no cheeks
  - Exception: Heart Blobs have full faces with emotions (happy, mad, sad)

## Evolutions

Each element line has three stages: baby (round blob) → middle form → adult.
All stages share the element's color.

| Element | Stage 1 (baby) | Stage 2 (middle) | Adult |
|---------|----------------|------------------|-------|
| Earth | `earth-blob-stage1` (brown circle) | `earth-blob-stage2` (brick) | `earth-blob` (pyramid) |
| Wind | `wind-blob-stage1` (blue circle) | `wind-blob-stage2` (small funnel) | `wind-blob` (tornado) |
| Water | `water-blob-stage1` (droplet circle) | `water-blob-stage2` (big sloshy blob) | TBC |
| Fire | `fire-blob-stage1` (ember circle) | `fire-blob-stage2` (flame) | TBC |
| Dark | `dark-blob-stage1` (shadow circle) | `dark-blob-stage2` (dark star) | `moon-blob` |
