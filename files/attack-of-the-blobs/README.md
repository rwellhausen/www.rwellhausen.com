# Attack of the Blobs — game art

Cartoon-style vector art for the video game *Attack of the Blobs*, drawn from
William's original pencil/crayon sketches (kept in `sketches/`).

SVGs are the editable masters (plain hex fills, named groups). PNGs are
rendered at working size; character PNGs have transparent backgrounds.

## The blob families

Every blob in the universe has three forms — baby → middle → final — and all
three share the family's colors. Going backward through the forms is called
"devolving". Files are named `<family>-blob-<form>.svg/.png`. William is
inventing the missing forms.

| Family (A–Z) | Baby | Middle | Final |
|--------------|------|--------|-------|
| Cloth | Pattern Blob (round, covered in patterns) | red dish cloth | red curtains on a rod |
| Cloud | puffy white cloud ball | big puffy cloud | three big puffy clouds together |
| Coal | coal pebble | big sparkly coal lump | burning furnace |
| Copper | oxidized copper ball | washer with a few strands of copper wire hair | copper pipe with lots of wire hair |
| Dark | shadow circle | dark star | crescent moon |
| Earth | brown circle | brick | brick pyramid |
| Fairy | round magenta blob | star wand with a wooden handle | bigger wand with four butterfly wings |
| Fire | ember circle | flame | erupting volcano |
| Firework | matchstick with a red head | striped rocket with lit fuse | teal-and-orange sparkler burst |
| Gem | round blue blob | pointed faceted diamond | blue crystal (approved, do not change) |
| Gold | round gold blob | gold bar (approved, do not change) | Gold King — crowned stack; lower bars strain to hold him up |
| Heart | round pink blob | single pink heart | touching trio with emotions: happy, mad, sad |
| Light | round yellow blob | beam of light | white fluffy cloud shining three beams |
| Water | droplet circle | big sloshy blob | curling wave |
| Wind | blue circle | small funnel | cloud tornado |

## Menu icons

| File | What it is |
|------|------------|
| `cartoon-icons.svg` / `.png` | 2×2 sheet: red book, Shop sign, Earth with dot eyes, crossed swords — the game's icon, shown at the top of the character gallery |

## Style rules

- Thick dark outlines (`#2b2340`), rounded joins
- Bright flat fills, minimal shading (one shine stripe max)
- Blobs get two dot eyes only — no mouths, no cheeks
  - Exceptions: Heart Blobs have full faces with emotions, and the Gold
    King's stack has a grinning king plus straining lower bars

## Game design notes (from William, July 28, 2026)

How the game is supposed to work — next steps:

### Worlds
- Clicking the **world icon** (the Earth square in the game icon) opens an
  image of **different worlds** to choose from.
- One of the worlds is **Hills**. (More worlds to be invented.)
- Clicking a world starts a **battle against other blobs** there.

### Battles
- You always **start with one blob**, and you use it to battle other blobs.
- **Higher forms beat lower forms**: e.g., a *middle* Water Blob beats a
  *baby* Fire Blob, because it's a whole form ahead.
- **Same form vs same form** comes down to element matchups,
  rock-paper-scissors style:
  - **Water beats Fire** (water puts out fire)
  - **Fire beats Wind** (William's ruling)
  - **Wind beats … something** — matchup chart still being invented
- More matchups for the other families (Earth, Dark, Light, Cloud, Coal,
  Copper, Gold, Gem, Cloth, Heart, Firework, Fairy) to be decided.

### Still to design
- The full element matchup chart
- What the levels look like inside a world (like Hills)
- How you collect more blobs and how they evolve during the game

## Worlds

| File | World |
|------|-------|
| `hills-world.svg` / `.png` | Hills — three round green hills with sunny yellow edges (first world) |
