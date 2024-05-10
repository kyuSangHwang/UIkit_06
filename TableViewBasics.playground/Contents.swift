import UIKit
import PlaygroundSupport

class TableViewExampleController: UIViewController, UITableViewDataSource {
    var tableView: UITableView?
    var journalEntries: [[String]] = [
        ["sun.max", "9 Apr 2023", "Nice weather today"],
        ["cloud.rain", "10 Apr 2023", "Heavy rain today"],
        ["cloud.sun", "11 Apr 2023", "It's cloudy out"]
    ]
    
    /// 주어진 indexPath에 해당하는 cell(일기의 아이콘, 날짜, 설명)의 데이터를 설정하고 반환. (UITableViewDataSource protocol을 사용하기 위해 구현해줘야 하는 함수)
    /// - Parameters:
    ///   - tableView: 데이터를 표시할 UITableView / 셀을 요청하는 UITableView 인스턴스
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
    ///   - tableView: 개수를 반환할 UITableView / 행 수를 요청하는 UITableView 인스턴스
    ///   - section: cell 개수를 반환할 section 번호 / 섹션의 인덱스
    /// - Returns: 주어진 section의 cell 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        journalEntries.count
    }
    
}
