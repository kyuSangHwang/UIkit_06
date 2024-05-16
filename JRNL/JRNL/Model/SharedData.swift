//
//  SharedData.swift
//  JRNL
//
//  Created by 황규상 on 5/16/24.
//

import UIKit

/// 싱글톤 패턴을 사용하여 SharedData 클래스를 정의.
class SharedData {
    static let shared = SharedData() // SharedData의 전역 인스턴스를 정의.
    private var journalEntries: [JournalEntry] // 일기 항목들을 저장할 배열을 선언.
    
    /// private init()을 사용하여 외부에서 인스턴스를 생성하지 못하도록 함.
    private init() {
        journalEntries = []
    }
    
    /// 현재 저장된 일기 항목의 수를 반환하는 Method.
    func numberOfJournalEntries() -> Int {
        journalEntries.count
    }
    
    /// 특정 인덱스의 일기 항목을 반환하는 Method.
    func getJournalEntry(index: Int) -> JournalEntry {
        journalEntries[index]
    }
    
    /// 모든 일기 항목을 반환하는 Method.
    func getAllJournalEntries() -> [JournalEntry] {
        // 배열의 읽기 전용 복사본을 반환.
        let readOnlyJournalEntries = journalEntries
        return readOnlyJournalEntries
    }
    
    /// 새로운 일기 항목을 추가하는 Method.
    func addJournalEntry(newJournalEntry: JournalEntry) {
        journalEntries.append(newJournalEntry)
    }
    
    /// 특정 인덱스의 일기 항목을 삭제하는 Method.
    func removeJournalEntry(index: Int) {
        journalEntries.remove(at: index)
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadJournalEntriesData() {
        let pathDirectory = getDocumentDirectory()
        let fileURL = pathDirectory.appendingPathComponent("journalEntriesData.json")
        do {
            let data = try Data(contentsOf: fileURL)
            let journalEntriesData = try JSONDecoder().decode([JournalEntry].self, from: data)
            journalEntries = journalEntriesData
        } catch {
            print("Failed to read JSON data: \(error.localizedDescription)")
        }
    }
    
    func savaJournalEntriesData() {
        let pathDirectory = getDocumentDirectory()
        try? FileManager.default.createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        let filePath = pathDirectory.appendingPathComponent("journalEntriesData.json")
        let json = try? JSONEncoder().encode(journalEntries)
        do {
            try json!.write(to: filePath)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
}
