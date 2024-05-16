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
    
    /// 위치 정보를 가져오기 위한 스위치 상태 변경 시 호출되는 Method
    @IBAction func getLocationSwitchValueChanged(_ sender: UISwitch) {
        if getLocationSwitch.isOn {
            getLocationSwitchLabel.text = "Getting location..."
            locationManager.requestLocation()
        } else {
            currentLocation = nil
            getLocationSwitchLabel.text = "Get location"
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    /// 위치 업데이트 시 호출되는 Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCurrentLocation = locations.first {
            currentLocation = myCurrentLocation
            getLocationSwitchLabel.text = "Done"
            updateSaveButtonState()
        }
    }
    
    /// 위치 업데이트 실패 시 호출되는 Method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    /// 저장 액션 메서드
    @objc func save() {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else {
            return
        }
        let photo = photoImageView.image
        let rating = 3
        let lat = currentLocation?.coordinate.latitude
        let long = currentLocation?.coordinate.longitude
        let journalEntry = JournalEntry(rating: rating, title: title, body: body, photo: photo, latitude: lat, longitude: long)!
        delegate?.saveJournalEntry(journalEntry)
        dismiss(animated: true)
    }
    
    /// 취소 액션 메서드
    @objc func cancel() {
        dismiss(animated: true)
    }

}
