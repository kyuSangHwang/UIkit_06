import UIKit
import PlaygroundSupport

class TableViewExampleController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView?
    var journalEntries: [[String]] = [
        ["sun.max", "9 Apr 2023", "Nice weather today"],
        ["cloud.rain", "10 Apr 2023", "Heavy rain today"],
        ["cloud.sun", "11 Apr 2023", "It's cloudy out"]
    ]
    
    /// 주어진 indexPath에 해당하는 cell(일기의 아이콘, 날짜, 설명)의 데이터를 설정하고 반환. (UITableViewDataSource protocol을 사용하기 위해 구현해줘야 하는 함수)
    /// - Parameters:
    ///   - tableView: 데이터를 표시할 UITableView instance
    ///   - indexPath: 설정할 cell의 indexPath / 테이블 뷰에서 셀의 위치를 지정하는 IndexPath
    /// - Returns: 설정된 데이터를 가진 UITableViewCell 객체
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let journalEntry = journalEntries[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: journalEntry[0])
        content.text = journalEntry[1]
        content.secondaryText = journalEntry[2]
        cell.contentConfiguration = content
        
        return cell
    }

    /// 주어진 section에 표시할 cell의 개수를 반환. (UITableViewDataSource protocol을 사용하기 위해 구현해줘야 하는 함수)
    /// - Parameters:
    ///   - tableView: 개수를 반환할 UITableView / 행 수를 요청하는 UITableView instance
    ///   - section: cell 개수를 반환할 section 번호 / 섹션의 인덱스
    /// - Returns: 주어진 section의 cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        journalEntries.count
    }
    
    /// 선택된 cell을 삭제하는 함수. (UITableViewDelegate protocol을 사용하기 위해 구현해줘야 하는 함수)
    /// - Parameters:
    ///   - tableView: 삭제 동작이 발생한 UITableView instance
    ///   - editingStyle: 수행된 편집 동작의 스타일 (삭제 또는 추가)
    ///   - indexPath: 편집 동작이 발생한 cell의 indexPath
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            journalEntries.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    /// 선택된 cell의 데이터를 출력하는 함수. (UITableViewDelegate protocol을 사용하기 위해 구현해줘야 하는 함수)
    /// - Parameters:
    ///   - tableView: 선택 동작이 발생한 UITableView instance
    ///   - indexPath: 선택된 cell의 indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedjournalEntry = journalEntries[indexPath.row]
        print(selectedjournalEntry)
    }
    
}
