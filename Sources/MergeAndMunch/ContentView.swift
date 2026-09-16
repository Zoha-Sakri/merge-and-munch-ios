import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var game: GameStore

    var body: some View {
        VStack(spacing: 0) {
            header
            Group {
                switch game.screen {
                case .farm: farm
                case .market: market
                case .shop: shop
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            navigation
        }
        .background(Color(red: 0.92, green: 0.98, blue: 0.96).ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            Text("MERGE\n& MUNCH").font(.headline.weight(.black)).foregroundStyle(Color(red: 0.15, green: 0.55, blue: 0.51))
            Spacer()
            Text("🪙 \(game.coins)   ⭐ \(game.stars)").font(.subheadline.weight(.black)).padding(9).background(.white, in: RoundedRectangle(cornerRadius: 12))
        }.padding(.horizontal, 20).padding(.vertical, 14)
    }

    private var farm: some View {
        ScrollView { VStack(alignment: .leading, spacing: 18) {
            Text("Sunny Farm").font(.system(size: 34, weight: .black)).foregroundStyle(Color(red: 0.19, green: 0.34, blue: 0.42))
            Text("GROW INGREDIENTS · SERVE THE MARKET").font(.caption.weight(.black)).foregroundStyle(.orange)
            VStack(alignment: .leading, spacing: 12) {
                Text("YOUR FIELDS").font(.caption.weight(.black)).foregroundStyle(Color(red: 0.22, green: 0.49, blue: 0.38))
                Text("Harvest fresh produce, then merge it into better recipes.").font(.subheadline)
                HStack(spacing: 8) {
                    ForEach(Array(game.plots.enumerated()), id: \.element.id) { index, plot in
                        Button { game.harvest(index) } label: {
                            VStack(spacing: 4) { Text(plot.ready ? "🌱" : "🪹").font(.system(size: 30)); Text(plot.family.emoji).font(.title3); Text(plot.ready ? "Harvest" : "Growing").font(.caption2.weight(.bold)) }
                                .frame(maxWidth: .infinity).padding(10).background(Color(red: 0.85, green: 0.95, blue: 0.82), in: RoundedRectangle(cornerRadius: 15))
                        }.buttonStyle(.plain)
                    }
                }
            }.padding(16).background(.white.opacity(0.88), in: RoundedRectangle(cornerRadius: 22))
            Text(game.message).font(.caption.weight(.bold)).foregroundStyle(Color(red: 0.22, green: 0.49, blue: 0.38))
            Button("Open Market Board") { game.show(.market) }.buttonStyle(.borderedProminent).tint(.orange)
        }.padding(20) }
    }

    private var market: some View {
        ScrollView { VStack(alignment: .leading, spacing: 12) {
            HStack { VStack(alignment: .leading) { Text("Market Board").font(.title2.weight(.black)); Text(game.message).font(.caption).foregroundStyle(.secondary) }; Spacer(); Button("Farm") { game.show(.farm) }.buttonStyle(.bordered) }
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 5), spacing: 6) {
                ForEach(game.board.indices, id: \.self) { index in Button { game.tap(index) } label: { TileView(item: game.board[index], selected: game.selected == index) }.buttonStyle(.plain) }
            }
            Text("ORDERS").font(.caption.weight(.black)).foregroundStyle(.orange)
            if game.orders.isEmpty { Text("All orders served. Grow more ingredients for the next market day!").font(.subheadline) }
            ForEach(Array(game.orders.enumerated()), id: \.element.id) { index, order in
                HStack { Text("👩‍🌾  \(order.family.emoji)").font(.title2); VStack(alignment: .leading) { Text(order.name).fontWeight(.black); Text("Level \(order.stage + 1) · +\(order.reward) coins").font(.caption).foregroundStyle(.secondary) }; Spacer(); Button("Serve") { game.serve(index) }.buttonStyle(.borderedProminent).tint(.orange) }
                    .padding(12).background(Color(red: 1, green: 0.98, blue: 0.91), in: RoundedRectangle(cornerRadius: 15))
            }
        }.padding(20) }
    }

    private var shop: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Market Shop").font(.system(size: 34, weight: .black)).foregroundStyle(Color(red: 0.19, green: 0.34, blue: 0.42))
            Text("Turn your farm into a warmer place to serve friends.")
            HStack { Text("🪴").font(.system(size: 42)); VStack(alignment: .leading) { Text("Happy plant").fontWeight(.black); Text("A little more life for Sunny Farm").font(.caption).foregroundStyle(.secondary) }; Spacer(); Button("🪙 180") { game.buyDecoration() }.buttonStyle(.borderedProminent).tint(.orange) }
                .padding(16).background(.white.opacity(0.88), in: RoundedRectangle(cornerRadius: 20))
            Text(game.message).fontWeight(.bold).foregroundStyle(Color(red: 0.22, green: 0.49, blue: 0.38))
            Spacer()
        }.padding(20)
    }

    private var navigation: some View {
        HStack { navButton("leaf.fill", "Farm", .farm); navButton("basket.fill", "Market", .market); navButton("bag.fill", "Shop", .shop) }
            .padding(.horizontal, 20).padding(.vertical, 10).background(.white.opacity(0.92))
    }

    private func navButton(_ icon: String, _ title: String, _ screen: GameScreen) -> some View {
        Button { game.show(screen) } label: { Label(title, systemImage: icon) }.frame(maxWidth: .infinity)
    }
}

private struct TileView: View {
    let item: Ingredient?
    let selected: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14).fill(item == nil ? Color(red: 0.77, green: 0.91, blue: 0.84) : Color(red: 0.58, green: 0.84, blue: 0.72)).overlay(RoundedRectangle(cornerRadius: 14).stroke(selected ? .yellow : .clear, lineWidth: 4))
            if let item { VStack(spacing: 0) { Text(item.family.emoji).font(.system(size: 29)); Text("Lv. \(item.stage + 1)").font(.caption2.weight(.black)).foregroundStyle(.white) } }
        }.aspectRatio(1, contentMode: .fit)
    }
}
