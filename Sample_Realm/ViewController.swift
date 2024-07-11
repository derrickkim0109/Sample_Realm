//
//  ViewController.swift
//  Sample_Realm
//
//  Created by Derrickk Kim on 7/1/24.
//

import RealmSwift
import UIKit

final class ViewController: UIViewController {
    lazy var rootVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameHStackView,
            ageHStackView,
            saveButton,
            descriptionLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var nameHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            nameTextField
        ])
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    
    let nameLabel: UILabel = {
        $0.text = "이름"
        return $0
    }(UILabel())
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름 입력"
        textField.borderStyle = .roundedRect
        textField.frame.size.height = 22
        return textField
    }()
    
    lazy var ageHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            ageLabel,
            ageTextField
        ])
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    
    let ageLabel: UILabel = {
        $0.text = "나이"
        return $0
    }(UILabel())
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이 입력"
        textField.borderStyle = .roundedRect
        textField.frame.size.height = 22
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "저장 되지 않음"
        label.numberOfLines = 0
        return label
    }()
    
    let manager = TranslationManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(rootVStackView)
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            rootVStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rootVStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rootVStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        saveButton.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside
        )

        let start = CFAbsoluteTimeGetCurrent()

        if let name = manager.fetchTranslationByKey(id: 1000) {
            let end = CFAbsoluteTimeGetCurrent()
            let timeElapsed = end - start
            let timeElapsedInMilliseconds = timeElapsed

            descriptionLabel.text = "총 10000개의 데이터 중 id == 1000인 값 검색 시간 : \(timeElapsedInMilliseconds) ms \n ID: 1000, Name: \(name)"
        }
        
        self.nameTextField.becomeFirstResponder()
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        let name = self.nameTextField.text ?? ""
        let age = self.ageTextField.text ?? ""
        
        let start = CFAbsoluteTimeGetCurrent()
        
        var translations = [(id: Int, name: String, age: String)]()
        for i in 0..<10000 {
            translations.append((id: i, name: name, age: age))
        }

        self.manager.save(translations: translations)

        let end = CFAbsoluteTimeGetCurrent()
        let timeElapsed = end - start
        let timeElapsedInMilliseconds = timeElapsed

        DispatchQueue.main.async {
            self.descriptionLabel.text = "총 10000개의 데이터 저장하는 데 걸린 시간 : \(timeElapsedInMilliseconds) ms"
        }
    }

}
