# iOS Agent Guide

This is the SwiftUI client for the original Merge & Munch farming-city game. Keep the core loop aligned with Web: harvest farm plots, merge ingredients, serve orders, earn coins/stars, buy decorations, upgrade the town, and explore Ancient City tunnels.

Minimum documented target is iOS 16+ with the latest installed Xcode SDK. Persist player state through the existing `GameStore`/`UserDefaults` approach. Do not copy Farm City branding, art, text, maps, characters, or exact progression.

Validate with an Xcode app target and iOS simulator/device when Xcode is available.