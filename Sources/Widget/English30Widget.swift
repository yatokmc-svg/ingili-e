import WidgetKit
import SwiftUI

struct English30Entry: TimelineEntry {
    let date: Date
    let word: VocabularyWord
}

struct English30Provider: TimelineProvider {
    func placeholder(in context: Context) -> English30Entry {
        .init(date: .now, word: Vocabulary.words[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (English30Entry) -> Void) {
        completion(.init(date: .now, word: Vocabulary.currentWord()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<English30Entry>) -> Void) {
        let now = Date.now
        let entries = (0..<6).map { offset in
            let date = now.addingTimeInterval(TimeInterval(offset * 30 * 60))
            return English30Entry(date: date, word: Vocabulary.currentWord(at: date))
        }
        let refreshDate = Vocabulary.nextRefresh(after: entries.last?.date ?? now)
        completion(Timeline(entries: entries, policy: .after(refreshDate)))
    }
}

struct English30WidgetView: View {
    let entry: English30Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(entry.word.word)
                .font(.system(.headline, design: .rounded).bold())
                .minimumScaleFactor(0.65)
                .lineLimit(1)
            Text(entry.word.example)
                .font(.system(size: 10, weight: .medium))
                .lineLimit(2)
                .minimumScaleFactor(0.7)
        }
        .widgetURL(URL(string: "english30://reveal"))
        .containerBackground(.clear, for: .widget)
    }
}

@main
struct English30Widget: Widget {
    let kind = "English30Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: English30Provider()) { entry in
            English30WidgetView(entry: entry)
        }
        .configurationDisplayName("English 30")
        .description("Learn one English word at a time.")
        .supportedFamilies([.accessoryRectangular, .accessoryInline])
    }
}
