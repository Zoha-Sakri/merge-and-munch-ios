# iOS Full Game Plan

## Product Loop
Harvest SwiftUI farm plots and care for cattle -> add goods to the market board -> merge equal-stage ingredients -> serve citizen orders -> earn coins, stars, experience, and happiness -> upgrade community buildings, restaurants, decorations, and wonders -> explore original Ancient City tunnels.

## Ownership
`Sources/MergeAndMunch/GameStore.swift` owns state, actions, persistence, save schema, economy, orders, buildings, and expeditions. SwiftUI views render the state. `project.yml` generates `MergeAndMunch.xcodeproj`; target iOS 16+ and current Xcode SDK.

## Implementation Standards
Use idiomatic SwiftUI, SF Rounded typography, safe areas, Dynamic Type, VoiceOver labels, comfortable controls, actionable alerts/sheets, loading/error/empty states, reduced motion, and UserDefaults migrations. Keep merge/economy behavior aligned with Web without sharing view code.

## Release Plan
Add app icon sets, launch/loading state, privacy text, in-app purchase decisions if ever needed, signing configuration, release scheme, archive validation, TestFlight testing, screenshots, age rating, and App Store metadata. Credentials and signing must remain local and never enter Git.

## Originality
Do not recreate Farm City or another game's branding, art, writing, maps, characters, UI, catalog, or progression. All game content is original.

## Validation
`cd ios && xcodegen generate`; `xcodebuild -project MergeAndMunch.xcodeproj -scheme MergeAndMunch -sdk iphonesimulator -configuration Debug build`; run on an iOS 16+ simulator and test persistence/rotation/accessibility.
