import Foundation

enum Family: String, Codable, CaseIterable {
    case tomato, cheese, bread, lettuce, fries, juice

    var emoji: String {
        switch self {
        case .tomato: "🍅"
        case .cheese: "🧀"
        case .bread: "🍞"
        case .lettuce: "🥬"
        case .fries: "🍟"
        case .juice: "🍊"
        }
    }
}

struct Ingredient: Identifiable, Codable, Equatable {
    let id: UUID
    let family: Family
    var stage: Int
}

struct Order: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let family: Family
    let stage: Int
    let reward: Int
}

struct FarmPlot: Identifiable, Codable, Equatable {
    let id: UUID
    let family: Family
    var ready: Bool
}

struct SaveState: Codable {
    var coins: Int
    var stars: Int
    var board: [Ingredient?]
    var plots: [FarmPlot]
    var orders: [Order]
}

extension Array where Element == Ingredient? {
    static var starter: [Ingredient?] {
        let values: [Family?] = [.tomato, .cheese, .tomato, nil, .bread, .lettuce, .cheese, .bread, .juice, .fries, .fries, nil, .lettuce, .juice, nil, .tomato, .cheese, nil, .bread, nil, .tomato, .fries, nil, .juice, nil]
        return values.map { family in family.map { Ingredient(id: UUID(), family: $0, stage: 0) } }
    }
}
