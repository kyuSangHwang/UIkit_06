//
//  JournalDetailViewController.swift
//  JRNL-Codeonly
//
//  Created by 황규상 on 5/13/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var stackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemMint
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 252),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

class JournalDetailViewController: UITableViewController {
    let journalEntry: JournalEntry
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .systemFill
        textView.textColor = .label
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(systemName: "face.smiling")
        iamgeView.contentMode = .scaleAspectFit
        iamgeView.translatesAutoresizingMaskIntoConstraints = false
        return iamgeView
    }()
    
    private lazy var mapView: UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(systemName: "map")
        iamgeView.contentMode = .scaleAspectFit
        iamgeView.translatesAutoresizingMaskIntoConstraints = false
        return iamgeView
    }()
    
    init(journalEntry: JournalEntry) {
        self.journalEntry = journalEntry
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// UITableViewCell타입의 셀을 "cell"이라는 고유한 식별자로 등록하겠다는 뜻
        /// 나중에 동일한 타입의 셀을 동일한 이름의 식별자로 접근해서 사용할 예정이지 등록하겠다는 뜻
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        navigationItem.title = "Detail"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let marginGuide = cell.contentView.layoutMarginsGuide
            cell.contentView.addSubview(dateLabel)
            dateLabel.text = journalEntry.date.formatted(.dateTime.year().month().day())
            NSLayoutConstraint.activate([
                dateLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as!
            CustomTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let marginGuide = cell.contentView.layoutMarginsGuide
            cell.contentView.addSubview(titleLabel)
            titleLabel.text = journalEntry.entryTitle
            NSLayoutConstraint.activate([
                titleLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let marginGuide = cell.contentView.layoutMarginsGuide
            cell.contentView.addSubview(bodyTextView)
            bodyTextView.text = journalEntry.entryBody
            NSLayoutConstraint.activate([
                bodyTextView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
                bodyTextView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
                bodyTextView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                bodyTextView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(imageView)
            imageView.image = journalEntry.photo
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 300),
                imageView.heightAnchor.constraint(equalToConstant: 300)
            ])
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(mapView)
            NSLayoutConstraint.activate([
                mapView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                mapView.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                mapView.widthAnchor.constraint(equalToConstant: 300),
                mapView.heightAnchor.constraint(equalToConstant: 300)
            ])
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1: return 60
        case 3: return 150
        case 4: return 316
        case 5: return 316
        default: return 44.5
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
