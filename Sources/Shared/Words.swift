import Foundation

struct VocabularyWord: Identifiable, Codable, Hashable {
    let id: Int
    let word: String
    let pronunciation: String
    let meaning: String
    let example: String
    let translation: String
}

enum Vocabulary {
    static let words: [VocabularyWord] = [
        .init(id: 1, word: "Overcome", pronunciation: "/ˌəʊvəˈkʌm/", meaning: "Üstesinden gelmek", example: "You can overcome any challenge.", translation: "Her türlü zorluğun üstesinden gelebilirsin."),
        .init(id: 2, word: "Reliable", pronunciation: "/rɪˈlaɪəbl/", meaning: "Güvenilir", example: "She is a reliable person to work with.", translation: "Birlikte çalışmak için güvenilir biridir."),
        .init(id: 3, word: "Eventually", pronunciation: "/ɪˈventʃuəli/", meaning: "Sonunda, eninde sonunda", example: "With practice, you will eventually improve.", translation: "Pratik yaparak eninde sonunda gelişeceksin."),
        .init(id: 4, word: "Efficient", pronunciation: "/ɪˈfɪʃənt/", meaning: "Verimli, etkili", example: "We need a more efficient way to work.", translation: "Çalışmak için daha verimli bir yönteme ihtiyacımız var."),
        .init(id: 5, word: "Hesitate", pronunciation: "/ˈhezɪteɪt/", meaning: "Tereddüt etmek", example: "Do not hesitate to ask for help.", translation: "Yardım istemekten çekinme.")
    ]

    /// The same five words repeat in 30-minute slots, starting at local midnight.
    static func currentWord(at date: Date = .now) -> VocabularyWord {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let elapsedSeconds = max(0, Int(date.timeIntervalSince(startOfDay)))
        let slot = (elapsedSeconds / 1_800) % words.count
        return words[slot]
    }

    static func nextRefresh(after date: Date = .now) -> Date {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let elapsedSeconds = max(0, date.timeIntervalSince(startOfDay))
        let nextSlot = (Int(elapsedSeconds / 1_800) + 1) * 1_800
        return startOfDay.addingTimeInterval(TimeInterval(nextSlot))
    }
}
