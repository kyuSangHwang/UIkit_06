//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by 황규상 on 5/13/24.
//

import UIKit

/// JournalListViewController 클래스 정의 (UIViewController를 상속받으며, UITableViewDataSource와 UITableViewDelegate 프로토콜을 채택함)
class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddJournalControllerDelegate {
    /// tableView 프로퍼티 정의 및 초기화
    var tableView: UITableView =  {
        let tableView = UITableView()
        return tableView
    }()
    
    var sampleJournalEntryData = SampleJournalEntryData()
    
    /// 뷰 컨트롤러의 로드 시점에 호출되는 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleJournalEntryData.createSampleJournalEntryData()
        
        
        // 테이블 뷰의 데이터 소스와 델리게이트를 현재 뷰 컨트롤러로 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블 뷰에 사용할 셀을 등록
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell")
        
        // 뷰의 배경색을 흰색으로 설정
        view.backgroundColor = .white
        
        // 테이블 뷰를 뷰에 추가
        view.addSubview(tableView)
        
        // 오토레이아웃 설정을 위해 테이블 뷰의 translatesAutoresizingMaskIntoConstraints 프로퍼티를 false로 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // 안전 영역 레이아웃 가이드 참조
        let safeArea = view.safeAreaLayoutGuide
        
        // 테이블 뷰의 오토레이아웃 제약 조건 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // 내비게이션 아이템의 타이틀 설정
        navigationItem.title = "Journal"
        
        // 내비게이션 아이템의 오른쪽 버튼을 "+" 버튼으로 설정하고, addJournal 메서드와 연결
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addJournal))
    }
    
    // MARK: - UITableViewDataSource Protocol Methods
    /// 테이블 뷰의 섹션별 행 개수를 반환하는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleJournalEntryData.journalEntries.count
    }
    
    /// 테이블 뷰의 각 행에 표시할 셀을 반환하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        
        cell.configureCell(journalEntry: journalEntry)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    /// 테이블 뷰의 행이 선택되었을 때 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journalDetailViewController = JournalDetailViewController() // JournalDetailViewController 인스턴스 생성
        show(journalDetailViewController, sender: self) // journalDetailViewController를 내비게이션 스택에 푸시하여 화면 전환
    }
    
    /// 테이블 뷰의 행 높이를 반환하는 메서드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Methods
    /// "+" 버튼이 탭되었을 때 호출되는 메서드
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController() // AddJournalViewController 인스턴스 생성
        let navController = UINavigationController(rootViewController: addJournalViewController) // UINavigationController를 사용하여 addJournalViewController를 모달로 표시
        addJournalViewController.delegate = self
        present(navController, animated: true)
    }
    
    public func saveJournalEntry(_ journalEntry: JournalEntry) {
        print("TEST \(journalEntry.entryTitle)")
    }
    
}
