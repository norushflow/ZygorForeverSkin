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
[[ $(grep -c '^## Interface:' "$toc") == 1 ]] || { echo 'Doppeltes Interface in der TOC.' >&2; exit 1; }
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
grep -Fxq '## X-Curse-Project-ID: 1804033' "$toc"
grep -Fxq '## X-Wago-ID: j6jAexNR' "$toc"
[[ $(grep -Ec '^## (X-Curse-Project-ID|X-Wago-ID):' "$toc") == 2 ]] ||
    { echo 'Doppelte Projekt-Metadaten in der TOC.' >&2; exit 1; }
awk -v addon='ZygorForeverSkin' -v notes='RELEASE_NOTES.md' \
    -v required='AGENTS.md RELEASE_NOTES.md tests tools TEMP dist Media/Expressway.ttf Media/MORPHEUS.TTF' '
    BEGIN { split(required, paths); for (i in paths) allowed[paths[i]]=1 }
    /^package-as:/ { if (NF != 2 || $2 != addon) exit 1; names++; next }
    /^manual-changelog:[[:space:]]*$/ { manual++; next }
    /^[[:space:]]+filename:/ { if (NF != 2 || $2 != notes) exit 1; filenames++; next }
    /^[[:space:]]+markup-type:/ { if (NF != 2 || $2 != "markdown") exit 1; markup++; next }
    /^ignore:[[:space:]]*$/ { ignore++; next }
    /^[[:space:]]+- / && ignore { if (NF != 2 || !allowed[$2] || seen[$2]++) exit 1; next }
    /^[[:space:]]*(#.*)?$/ { next }
    { exit 1 }
    END {
        if (names != 1 || manual != 1 || filenames != 1 || markup != 1 || ignore != 1) exit 1
        for (i in paths) if (!seen[paths[i]]) exit 1
    }
' .pkgmeta || { echo 'Ungültige CurseForge-Paketkonfiguration.' >&2; exit 1; }
if ! grep -Fxq '## IconTexture: Interface\AddOns\ZygorForeverSkin\Media\Icon.tga' "$toc" || [[ ! -s Media/Icon.tga ]]; then
    echo 'IconTexture fehlt in der TOC oder die zugehörige Icon-Datei fehlt.' >&2
    exit 1
fi
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
