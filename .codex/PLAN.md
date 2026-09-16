# iOS Full Game Plan

Merge & Munch is an original SwiftUI farming-city game. Implement the loop farm/cattle -> merge board -> citizen trade -> town upgrades -> Ancient City exploration.

Keep domain state and persistence in `GameStore`; keep SwiftUI rendering in `ContentView` and focused views. Model crop readiness, animals/products, merge chains, order quantity/patience/rewards, building levels/happiness, decorations, tunnel depth, and versioned saves.

Use SF Rounded for the friendly premium native type direction. Support iOS 16+, Dynamic Type, VoiceOver, safe areas, reduced motion, actionable alerts, and small-screen layouts. Prepare app icons, privacy/store metadata, signing, TestFlight, and release archive steps without committing credentials.

Never copy Farm City or any other protected content. Validate with XcodeGen and xcodebuild, then run the simulator.
