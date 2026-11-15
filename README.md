# Zygor Forever Skin

Zygor Forever Skin gives the Zygor Guide Viewer on World of Warcraft Forever a dark bronze theme inspired by ForeverBuddy. The skin uses Zygor's own interface, leaving guide selection, quest progress, navigation, and settings in Zygor's hands.

## Compatibility

Built for WoW Forever **1.60.1** (interface 16001, build 70938) and checked against **Zygor Guide Viewer Forever 1.6** (revision 37602). Install and enable `ZygorGuidesViewerForever` separately. The skin works independently of ForeverBuddy and ForeverBuddyUI.

## Installation

1. Download the installation ZIP from [Releases](https://github.com/norushflow/ZygorForeverSkin/releases).
2. Extract the `ZygorForeverSkin` folder into `_forever_/Interface/AddOns/`.
3. Enable **Zygor Forever Skin** and **Zygor Guide Viewer (Forever)** in the AddOns menu. If WoW is open, enter `/reload` in chat.

To restore Zygor's original look, disable **Zygor Forever Skin** and run `/reload`.

## What the skin covers

- The quest viewer, guide tabs, quest steps, progress bars, guide selector, menus, and supported settings and preview panels use the dark bronze palette.
- The standard waypoint marker uses a gold tint. The direction arrow keeps its native red, amber, and green cues. Map routes, special pins, protected action buttons, and shared Blizzard tooltips keep their native appearance.
- The skin can use a locally installed Expressway font. Otherwise it uses the WoW font at `Fonts/FRIZQT__.TTF` when available. Chinese and Korean locales retain Zygor's fonts, as do labels that use fixed font files. The download contains no fonts, Zygor files, or guide content.

## Attribution

Zygor Forever Skin is an independent, unofficial skin for Zygor Guide Viewer. Zygor Guides is a trademark of its respective owner. This project is neither affiliated with nor endorsed by Zygor Guides.

## Local checks and build

With LuaJIT, ZIP tools, and Zygor Guide Viewer Forever installed, run `./tools/check-local.sh` to check the TOC, Lua syntax, and all four built-in Zygor styles. The tests simulate loading, reload, guide windows created on demand, combat deferral, protected frames, and a missing Zygor installation.

Run `./tools/build.sh` to check and build the installable ZIP. For a local client test, run `./tools/spieltest.sh ZygorForeverSkin` from the parent WoW addon project in the Fedora terminal. WoW can stay open. Once installation succeeds, enter `/reload` in WoW chat and check the skin.

Publish only when explicitly requested. The full check requires the locally installed Zygor reference. For Wago, `wago-release.yml` defaults to a dry run; after checking the version is absent, use `dry_run=false` and `confirm_new=<tag>` with the `WAGO_API_TOKEN` GitHub secret and a `WAGO_PROJECT_ID` variable matching the TOC. If an upload has an uncertain outcome, check Wago and use the displayed `recover_status_id` only when the version is absent. Verify GitHub, CurseForge and Wago separately.

The CurseForge webhook can package a pushed tag using `.pkgmeta` and `RELEASE_NOTES.md`. Check published and pending files before any manual upload to avoid duplicates.
