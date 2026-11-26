import SwiftUI

@main
struct English30App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var revealed = false
    @State private var now = Date.now
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    private var word: VocabularyWord { Vocabulary.currentWord(at: now) }

    var body: some View {
        ZStack {
            Color(red: 0.07, green: 0.13, blue: 0.19).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 22) {
                HStack {
                    Text("ENGLISH 30").font(.caption.bold()).tracking(2)
                    Spacer()
                    Text("B1–B2")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 12).padding(.vertical, 7)
                        .background(.white.opacity(0.12), in: Capsule())
                }
                Spacer(minLength: 24)
                Text(word.word)
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .minimumScaleFactor(0.6).lineLimit(1)
                Text(word.pronunciation).foregroundStyle(.white.opacity(0.65))
                if revealed {
                    Text(word.meaning).font(.title2.bold()).transition(.opacity)
                } else {
                    Button {
                        withAnimation(.easeInOut) { revealed = true }
                    } label: {
                        Label("Türkçe anlamı göster", systemImage: "eye")
                            .font(.subheadline.weight(.semibold))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.17, green: 0.43, blue: 0.58))
                }
                Divider().overlay(.white.opacity(0.2))
                Text("EXAMPLE").font(.caption.bold()).tracking(1.5)
                    .foregroundStyle(.white.opacity(0.6))
                Text(word.example).font(.title3.weight(.medium))
                if revealed {
                    Text(word.translation).font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                Spacer(minLength: 24)
                HStack {
                    Text("TODAY'S WORD")
                    Spacer()
                    Text(String(format: "%02d / 05", word.id))
                }
                .font(.caption.bold()).foregroundStyle(.white.opacity(0.55))
            }
            .foregroundStyle(.white)
            .padding(26)
        }
        .preferredColorScheme(.dark)
        .onReceive(timer) { date in
            let previousID = Vocabulary.currentWord(at: now).id
            now = date
            if Vocabulary.currentWord(at: date).id != previousID {
                revealed = false
            }
        }
        .onOpenURL { url in
            guard url.scheme == "english30", url.host == "reveal" else { return }
            withAnimation(.easeInOut) { revealed = true }
        }
    }
}
