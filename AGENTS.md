# ZygorForeverSkin

Eigenständiges Skin für Forever. Laufzeitdateien in der TOC. Das installierte
`ZygorGuidesViewerForever` und die Buddy-Addons sind Referenzen für die Entwicklung.

- Mit Git-Status, TOC und relevantem Diff beginnen.
- Zygor-Optionen und Bedienlogik erhalten. Geschützte und verbotene Frames auslassen.
- Nach Änderungen `./tools/check-local.sh` oder den lokalen ZIP-Bau ausführen.
- Gemeinsame Regeln im übergeordneten `AGENTS.md` beachten. Veröffentlichung nur nach ausdrücklichem Auftrag; ZIP und Plattformen getrennt prüfen, unklare Uploads nicht blind wiederholen, keine Secrets ausgeben. Ablauf in `README.md`.
- `.pkgmeta` muss zur ZIP-Dateiliste passen; `RELEASE_NOTES.md` ist der CurseForge-Changelog.
- Nach jedem abgeschlossenen Testlauf die Antwort mit dem kopierbaren Fedora-Befehl abschließen. Für den Spieltest auch nach erfolgreicher Installation `cd /mnt/UserData/Dokumente/ChatGPT/wow_addon && ./tools/spieltest.sh ZygorForeverSkin` angeben. Bei geöffnetem WoW danach `/reload` im Chat ausführen.
