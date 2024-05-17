//
//  SharedData.swift
//  JRNL-Codeonly
//
//  Created by 황규상 on 5/17/24.
//

import UIKit

class SharedData {
    static let shared = SharedData()
    private var journalEntries: [JournalEntry]
    
    private init() {
        journalEntries = []
    }
    
    func numberOfJournalEntries() -> Int {
        journalEntries.count
    }
    
    func getJournalEntry(index: Int) -> JournalEntry {
        journalEntries[index]
    }
    
    func getAllJournalEntries() -> [JournalEntry] {
        let readOnlyJournalEntries = journalEntries
        return readOnlyJournalEntries
    }
    
    func addJournalEntry(newJournalEntry: JournalEntry) {
        journalEntries.append(newJournalEntry)
    }
    
    func removeJournalEntry(index: Int) {
        journalEntries.remove(at: index)
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadJournalEntriesData() {
        // 일기 데이터가 저장된 JSON 파일의 URL을 가져옴
        let fileURL = getDocumentDirectory().appendingPathComponent("journalEntriesData.json")
        do {
            // 파일 URL에서 데이터를 읽어옴
            let data = try Data(contentsOf: fileURL)
            // JSON 데이터를 디코딩하여 JournalEntry 배열로 변환
            let journalEntriesData = try JSONDecoder().decode([JournalEntry].self, from: data)
            // 디코딩된 데이터를 journalEntries 변수에 저장
            journalEntries = journalEntriesData
        } catch {
            // 데이터 읽기 또는 디코딩 실패 시 에러 메시지 출력
            print("Failed to read JSON data: \(error.localizedDescription)")
        }
    }
    
    func saveJournalEntriesData() {
        // 일기 데이터를 저장할 디렉토리 경로를 가져옴
        let pathDirectory = getDocumentDirectory()
        // 디렉토리가 없으면 생성
        try? FileManager.default.createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        // JSON 파일의 URL을 생성
        let fileURL = pathDirectory.appendingPathComponent("journalEntriesData.json")
        // journalEntries 데이터를 JSON 형식으로 인코딩
        let json = try? JSONEncoder().encode(journalEntries)
        do {
            // 인코딩된 JSON 데이터를 파일에 씀
            try json!.write(to: fileURL)
        } catch {
            // 데이터 쓰기 실패 시 에러 메시지 출력
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }

}
