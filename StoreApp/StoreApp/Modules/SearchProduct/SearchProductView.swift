//
//  SearchProductView.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

final class SearchProductView: UIView {
    // MARK: - Public propertie
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.placeholder = "Type the product here"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.backgroundColor = .lightGray
        button.setTitle("Search", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func handleLoading(isLoading: Bool) {
        isLoading ? submitButton.showLoading() : submitButton.hideLoading()
        submitButton.titleLabel?.alpha = isLoading ? 0 : 1
    }
    
    // MARK: - Private methods
    private func shouldEnableButton(charNumber: Int) {
        submitButton.isEnabled = charNumber > 2
        submitButton.backgroundColor = charNumber > 2 ? .blue : .lightGray
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        addGestureRecognizer(tap)
    }
    
    @objc private func closeKeyboard() {
        endEditing(true)
    }
}

// MARK: - ViewConfiguration
extension SearchProductView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [searchTextField, submitButton])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //searchTextField
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            searchTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            searchTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            //submitButton
            submitButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
            submitButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            submitButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
        setupGestures()
    }
}

// MARK: - UITextFieldDelegate
extension SearchProductView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = textField.text
        if string == "" {
            text = String(text?.dropLast() ?? "")
        } else {
            text = "\(text ?? "")\(string)"
        }
        
        shouldEnableButton(charNumber: text?.count ?? 0)
        return true
    }
}
