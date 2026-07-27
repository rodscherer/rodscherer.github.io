#!/usr/bin/env bash
# Gera as imagens ilustrativas dos cards de projeto a partir de referências
# de domínio público (Openverse), usando FLUX.2 [klein] em modo edit, local.
set -uo pipefail

GEN=~/.claude/scripts/generate-image.sh
REF="${REF_DIR:?defina REF_DIR com a pasta das referências}"
OUT="$(cd "$(dirname "$0")" && pwd)/assets"

STYLE="Warm bone-white background, soft diffused daylight, long gentle shadow, generous negative space, calm minimal composition, muted natural palette of cream, sand, warm brown and sage. High-end editorial photography for a footwear design portfolio. No text, no logos, no watermark, no brand marks."

gen() { # nome ref prompt
  local name=$1 ref=$2 prompt=$3
  [ -f "$OUT/$name.jpg" ] && { echo "skip $name"; return; }
  MFLUX_WIDTH=1344 MFLUX_HEIGHT=1008 "$GEN" "$prompt $STYLE" "$OUT/$name.png" \
    -i "$REF/$ref" && echo "done $name" || echo "FALHOU $name"
}

gen card-infantil ref-infantil.jpg \
  "A pair of children's casual sneakers in soft muted tones, seen from above on a clean studio surface, laces neatly arranged, contemporary kids footwear catalogue still life."

gen card-desenvolvimento ref-materiais.jpg \
  "Footwear development still life: leather and textile swatches fanned out on a clean studio surface next to a technical sketch of a shoe on paper, a few colour chips beside them."

gen card-modelagem ref-modelagem.jpg \
  "Shoemaking still life: two wooden shoe lasts and flat paper pattern pieces arranged on a clean workbench, a metal ruler and a marking awl beside them."

echo "ALL DONE"
