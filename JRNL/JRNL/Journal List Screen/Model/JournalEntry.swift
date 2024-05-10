//
//  JournalEntry.swift
//  JRNL
//
//  Created by 황규상 on 5/10/24.
//

import UIKit

/// JournalEntry 클래스는 일기 엔트리를 나타내는 모델.
class JournalEntry {
    // MARK: - Properties
    
    let date: Date
    let rating: Int
    let entryTitle: String
    let entryBody: String
    let photo: UIImage?
    let latitude: Double?
    let longitude: Double?

    /// JournalEntry 인스턴스를 초기화하는 이니셜라이저.
    /// - Parameters:
    ///   - date: 일기 엔트리의 날짜
    ///   - rating: 일기 엔트리의 평점 (0부터 5까지의 정수)
    ///   - title: 일기 엔트리의 제목
    ///   - body: 일기 엔트리의 본문 내용
    ///   - photo: 일기 엔트리에 첨부된 사진 (옵셔널)
    ///   - latitude: 일기 엔트리의 위도 (옵셔널)
    ///   - longitude: 일기 엔트리의 경도 (옵셔널)
    // MARK: - Initialization
    init?(rating: Int, title: String, body: String, photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        if title.isEmpty || body.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
        
        self.date = Date()
        self.rating = rating
        self.entryTitle = title
        self.entryBody = body
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Sample data
    /// <#Description#>
    struct SampleJournalEntryData {
        var journalEntries: [JournalEntry] = []
        mutating func createSampleJournalEntryData() {
            let photo1 = UIImage(systemName: "sun.max")
            let photo2 = UIImage(systemName: "cloud")
            let photo3 = UIImage(systemName: "cloud.sun")
            guard let journalEntry1 = JournalEntry(rating: 5, title: "Good", body: "Today is a good day", photo: photo1),
                  let journalEntry2 = JournalEntry(rating: 0, title: "Bad", body: "Today is a bad day", photo: photo2),
                  let journalEntry3 = JournalEntry(rating: 3, title: "Ok", body: "Today is an Ok day", photo: photo3) else {
                fatalError("Unable to instantiate journalEntries")
            }
            journalEntries += [journalEntry1, journalEntry2, journalEntry3]
        }
    }
}
