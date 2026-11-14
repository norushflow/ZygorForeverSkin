#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

wow=${1:-/home/norushflow/Games/World of Warcraft}
zyg="$wow/_forever_/Interface/AddOns/ZygorGuidesViewerForever"
toc=ZygorForeverSkin.toc
zygortoc="$zyg/ZygorGuidesViewerForever.toc"

command -v luajit >/dev/null || { echo 'LuaJIT fehlt.' >&2; exit 1; }
if [[ ! -f $zygortoc ]]; then
    printf 'Zygor-TOC für den Integrationstest fehlt: %s\n' "$zygortoc" >&2
    exit 1
fi
interface=$(awk '/^## Interface:/ {print $3; exit}' "$toc")
zygor_interface=$(awk '/^## Interface:/ {sub(/\r$/, ""); print $3; exit}' "$zygortoc")
if [[ $interface != 16001 || $interface != "$zygor_interface" ]]; then
    echo 'Interface von Skin und installiertem Zygor passt nicht zu Forever 1.60.1.' >&2
    exit 1
fi
if [[ -f "$wow/.build.info" ]] && ! awk -F '|' '
    $2 == 1 && $NF == "wowf" && $(NF-2) ~ /^1\.60\.1\./ { found=1 }
    END { exit !found }
' "$wow/.build.info"; then
    echo 'In .build.info fehlt der aktive Forever-Client 1.60.1.' >&2
    exit 1
fi
grep -Fxq '## OptionalDeps: ZygorGuidesViewerForever' "$toc"
if grep -Ei '^##[[:space:]]*(Dependencies|RequiredDeps|SavedVariables(PerCharacter)?):' "$toc"; then
    echo 'Unerwartete Abhängigkeit oder SavedVariables in der TOC.' >&2
    exit 1
fi

mapfile -t runtime < <(awk 'NF && $1 !~ /^#/ {print}' "$toc")
if [[ ${runtime[*]} != 'Style.lua Core.lua' ]]; then
    echo 'Unerwartete TOC-Ladereihenfolge.' >&2
    exit 1
fi
luajit - "${runtime[@]}" tests/test_skin.lua <<'LUA'
for _, path in ipairs(arg) do assert(loadfile(path)) end
LUA
luajit tests/test_skin.lua "$zyg"
printf 'ZygorForeverSkin OK (Interface %s, %s Laufzeitdateien)\n' "$interface" "${#runtime[@]}"
