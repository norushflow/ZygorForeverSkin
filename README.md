# Zygor Skin (Retail & Forever)

<p align="center"><img src="branding/icon.png" width="144" height="144" alt="ZygorForeverSkin icon"></p>

Zygor Forever Skin gives the Zygor Guide Viewer on World of Warcraft Retail and Forever a dark bronze theme inspired by ForeverBuddy. The skin uses Zygor's own interface, leaving guide selection, quest progress, navigation, and settings in Zygor's hands.

[Wago](https://addons.wago.io/addons/zygorforeverskin) · [GitHub Releases](https://github.com/norushflow/ZygorForeverSkin/releases)

## Compatibility

Supports Retail (interface **120105**, Zygor 9.6) and Forever (interface **16001**, Zygor Forever 1.6). Install the matching Zygor viewer separately. One shared codebase and ZIP; independent of the Buddy addons.

## Installation

1. Download the installation ZIP from [Releases](https://github.com/norushflow/ZygorForeverSkin/releases).
2. Extract the `ZygorForeverSkin` folder into `_retail_/Interface/AddOns/` or `_forever_/Interface/AddOns/`.
3. Enable **Zygor Skin** and the matching **Zygor Guide Viewer** in the AddOns menu. If WoW is open, enter `/reload` in chat.

To restore Zygor's original look, disable **Zygor Skin** and run `/reload`.

If you previously installed `ZygorRetailSkin`, remove or disable it before enabling this addon and reload. The folder stays named `ZygorForeverSkin` to preserve existing update links.

## What the skin covers

- The quest viewer, guide tabs, quest steps, progress bars, guide selector, menus, and supported settings and preview panels use the dark bronze palette.
- The standard waypoint marker uses a gold tint. The direction arrow keeps its native red, amber, and green cues. Map routes, special pins, protected action buttons, and shared Blizzard tooltips keep their native appearance.
- The skin can use a locally installed Expressway font. Otherwise it uses the WoW font at `Fonts/FRIZQT__.TTF` when available. Chinese and Korean locales retain Zygor's fonts, as do labels that use fixed font files. The download contains no fonts, Zygor files, or guide content.

## Attribution

Zygor Forever Skin is an independent, unofficial skin for Zygor Guide Viewer. Zygor Guides is a trademark of its respective owner. This project is neither affiliated with nor endorsed by Zygor Guides.

## Local checks and build

With LuaJIT, ZIP tools, and both Zygor client versions installed, run `./tools/check-local.sh` to check the TOC, Lua syntax, and all four built-in Zygor styles in both clients. The tests simulate loading, reload, guide windows created on demand, combat deferral, protected frames, and a missing Zygor installation.

Run `./tools/build.sh` to check and build the installable ZIP. For a local client test, run `./tools/spieltest.sh ZygorForeverSkin-Retail` or `./tools/spieltest.sh ZygorForeverSkin-Forever` from the parent WoW addon project in the Fedora terminal. WoW can stay open. Once installation succeeds, enter `/reload` in WoW chat and check the skin.

## Release

Publish only on an explicit request; failed checks block publication. Reuse a confirmed client test of the same code.

1. Check the remote; update the TOC version and `RELEASE_NOTES.md`.
2. Run `./tools/build.sh` once with the installed Zygor reference; it includes the full check. Commit/push the changes and publish the matching GitHub tag/release with that ZIP. Confirm the commit and ZIP once.
3. CurseForge: check webhook-created files, including pending files. `.pkgmeta` uses `RELEASE_NOTES.md` as the changelog. Upload manually only if the version is absent and no upload is running. Report pending moderation without waiting.
4. Wago: check the project and that the version is absent, then run `wago-release.yml` once with `tag=<tag>`, `dry_run=false`, `confirm_new=<tag>`. Report GitHub, CurseForge and Wago separately.

Wago requires secret `WAGO_API_TOKEN` and variable `WAGO_PROJECT_ID` matching the TOC. Dry run remains the default; an unchanged, verified setup needs no extra dry run. For an uncertain upload, check the platform first; use `recover_status_id` only if the version is confirmed absent. Never retry blindly or expose secrets.
