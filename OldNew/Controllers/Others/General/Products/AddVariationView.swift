//
//  AddVariationView.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/19.
//

//import UIKit
//
//class AddVariationView: UIView {
//    private let variationName: UITextView = {
//        let field = UITextView()
//        field.text = "Variation name (no more than 50 characters)"
//        field.font = UIFont.systemFont(ofSize: 17)
//        field.textColor = .lightGray
//        field.backgroundColor = .white
//        field.isScrollEnabled = true
//        field.textContainer.lineBreakMode = .byCharWrapping
//        return field
//    }()
//    private let quatity: UITextField = {
//        let field = UITextField()
//        field.placeholder = "Quantity"
//        field.backgroundColor = .white
//        return field
//    }()
//    private let addVariationButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Add", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .link
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        return button
//    }()
//    private let cancelButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Cancel", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .white
//        button.layer.borderWidth = 0.5
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        return button
//    }()
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}

import UIKit

protocol AddVariationViewDelegate: AnyObject {
    func addVariationViewDidSubmitData(name: String, quantity: String)
    func addVariationViewDidCancel()
}

class AddVariationView: UIView {
    weak var delegate: AddVariationViewDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quantity:"
        return label
    }()

    private let quantityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.addTarget(AddVariationView.self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.addTarget(AddVariationView.self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8.0
        layer.masksToBounds = true

        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(quantityLabel)
        addSubview(quantityLabel)
        addSubview(submitButton)
        addSubview(cancelButton)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            quantityLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            quantityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            quantityLabel.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),

            submitButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 32),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            cancelButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 8),
            cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    @objc private func submitButtonTapped() {
        guard let name = nameTextField.text, let quantity = quantityLabel.text else { return }
        delegate?.addVariationViewDidSubmitData(name: name, quantity: quantity)
    }

    @objc private func cancelButtonTapped() {
        delegate?.addVariationViewDidCancel()
    }
}
