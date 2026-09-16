import Combine
import Foundation

enum GameScreen {
    case farm, market, shop
}

final class GameStore: ObservableObject {
    @Published private(set) var board: [Ingredient?]
    @Published private(set) var coins: Int
    @Published private(set) var stars: Int
    @Published private(set) var plots: [FarmPlot]
    @Published private(set) var orders: [Order]
    @Published var selected: Int?
    @Published var message = "Harvest a crop, then merge ingredients into a recipe."
    @Published var screen: GameScreen = .farm

    private let saveKey = "merge-and-munch.save"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey), let saved = try? JSONDecoder().decode(SaveState.self, from: data) {
            board = saved.board
            coins = saved.coins
            stars = saved.stars
            plots = saved.plots
            orders = saved.orders
        } else {
            board = .starter
            coins = 1240
            stars = 18
            plots = [FarmPlot(id: UUID(), family: .tomato, ready: true), FarmPlot(id: UUID(), family: .lettuce, ready: true), FarmPlot(id: UUID(), family: .juice, ready: true)]
            orders = [Order(id: UUID(), name: "Garden sauce", family: .tomato, stage: 1, reward: 65), Order(id: UUID(), name: "Cheese bites", family: .cheese, stage: 0, reward: 65)]
        }
    }

    func show(_ screen: GameScreen) {
        self.screen = screen
        selected = nil
    }

    func harvest(_ index: Int) {
        guard plots.indices.contains(index), plots[index].ready else { return }
        guard let empty = board.firstIndex(where: { $0 == nil }) else { message = "Your market board is full."; return }
        board[empty] = Ingredient(id: UUID(), family: plots[index].family, stage: 0)
        plots[index].ready = false
        message = "Harvest added to your market!"
        save()
    }

    func serve(_ index: Int) {
        guard orders.indices.contains(index) else { return }
        let order = orders[index]
        guard let found = board.firstIndex(where: { item in item?.family == order.family && (item?.stage ?? -1) >= order.stage }) else { message = "Keep farming and merging first!"; return }
        board[found] = nil
        orders.remove(at: index)
        coins += order.reward
        stars += 1
        message = "Order served! +\(order.reward) coins"
        save()
    }

    func buyDecoration() {
        guard coins >= 180 else { message = "You need more coins for that decoration."; return }
        coins -= 180
        message = "Happy plant added to your farm!"
        save()
    }

    func tap(_ index: Int) {
        guard board.indices.contains(index) else { return }
        guard let sourceIndex = selected else {
            if board[index] != nil { selected = index; message = "Choose its matching ingredient." }
            return
        }
        guard sourceIndex != index else { selected = nil; return }
        guard let source = board[sourceIndex] else { selected = nil; return }
        guard let target = board[index] else {
            board[index] = source
            board[sourceIndex] = nil
            selected = nil
            message = "Moved!"
            save()
            return
        }
        guard source.family == target.family, source.stage == target.stage, source.stage < 5 else {
            selected = nil
            message = "Those ingredients do not match yet."
            return
        }
        board[sourceIndex] = nil
        board[index] = Ingredient(id: UUID(), family: target.family, stage: target.stage + 1)
        let reward = 15 * (target.stage + 1)
        coins += reward
        selected = nil
        message = "Sweet merge! +\(reward) coins"
        save()
    }

    private func save() {
        let state = SaveState(coins: coins, stars: stars, board: board, plots: plots, orders: orders)
        guard let data = try? JSONEncoder().encode(state) else { return }
        UserDefaults.standard.set(data, forKey: saveKey)
    }
}
