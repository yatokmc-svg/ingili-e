# English 30

A small iPhone vocabulary app and Lock Screen widget for five daily B1–B2 English words.

## Features
- Lock Screen rectangular widget shows the English word and example sentence only.
- Tapping the widget opens the app and reveals the Turkish meaning and translated example.
- Five words repeat in a 30-minute cycle throughout the day.
- No network connection is required.
- WidgetKit refreshes are requested every 30 minutes. iOS controls the actual refresh schedule and may delay updates.

## Build
This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen). Open `project.yml` in an XcodeGen setup, or run `xcodegen generate` on macOS with Xcode installed.

The GitHub Actions workflow at `.github/workflows/build-ios.yml` builds an unsigned IPA on a macOS runner and uploads it as a workflow artifact. The IPA must then be signed for your device. Sideloadly supports free Apple IDs, but free-account installs normally expire after seven days and need refreshing.

## Important
A free Apple Account is not the same as a paid Apple Developer Program membership. Do not put your Apple password, verification code, certificate, or provisioning profile in this public repository.
