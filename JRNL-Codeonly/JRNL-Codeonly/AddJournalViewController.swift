//
//  AddJournalViewController.swift
//  JRNL-Codeonly
//
//  Created by 황규상 on 5/13/24.
//

import UIKit
import CoreLocation

/// JournalEntry를 저장하기 위한 델리게이트 프로토콜 정의
protocol AddJournalControllerDelegate: AnyObject {
    func saveJournalEntry(_ journalEntry: JournalEntry)
}

class AddJournalViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate {
    // IBOutlet을 사용하여 인터페이스 빌더에서 UI 요소를 연결
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var getLocationSwitch: UISwitch!
    @IBOutlet var getLocationSwitchLabel: UILabel!
    
    // 델리게이트 변수 및 위치 관련 변수 초기화
    weak var delegate: AddJournalControllerDelegate?
    var newJournalEntry: JournalEntry?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        
        return stackView
    }()
    
    private lazy var ratingView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemRed
        
        return stackView
    }()
    
    private lazy var toggleView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        let switchComponent = UISwitch()
        let labelComponent = UILabel()
        labelComponent.text = "Switch Label"
        stackView.addArrangedSubview(switchComponent)
        stackView.addArrangedSubview(labelComponent)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트 필드와 텍스트 뷰의 델리게이트 설정
        titleTextField.delegate = self
        bodyTextView.delegate = self
        
        // 저장 버튼 상태 업데이트
        updateSaveButtonState()
        
        // 위치 관리자 델리게이트 설정 및 위치 권한 요청
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        // 네비게이션 아이템 설정
        navigationItem.title = "New Entry"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        setupView() // 추가적인 뷰 설정
    }
    
    /// 저장 버튼 상태를 업데이트하는 Method
    private func updateSaveButtonState() {
        let textFieldText = titleTextField.text ?? ""
        let textViewText = bodyTextView.text ?? ""
        if getLocationSwitch.isOn {
            saveButton.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty && !(currentLocation == nil)
        } else {
            saveButton.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty
        }
    }
    
    /// 추가적인 뷰 설정 Method
    private func setupView() {
        photoImageView.image = UIImage(systemName: "face.smiling")
    }
    
    @objc func save() {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else {
            return
        }
        let journalEntry = JournalEntry(rating: 3, title: title, body: body, photo: UIImage(systemName: "face.smiling"))!
        delegate?.saveJournalEntry(journalEntry)
        dismiss(animated: true)
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }

}
