//
//  AddVariationViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/17.
//

import UIKit

protocol AddVariationViewControllerDelegate: AnyObject {
    func addVariationViewDidSubmitData(name: String, color: String, size: String, usageStatus: String, quantity: Int, price: Int)
}

class AddVariationViewController: UIViewController {

    weak var delegate: AddVariationViewControllerDelegate?
    
    var variation: Variations?
    
    public func editVariation(with data: Variations){
        self.variation = data
        variationName.text = variation?.name
        colorTextField.text = variation?.color
        sizeTextField.text = variation?.size
        usageStatusButton.titleLabel?.text = variation?.usageStatus
        quantity.text = "\(String(describing: variation?.quantity))"
        priceTextField.text = "\(String(describing: variation?.price))"
    }
    
    var isButtonTapped: Bool = false
    
    let addView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let variationName: UITextField = {
        let field = UITextField()
        field.placeholder = "Variation name (no more than 50 characters)"
        field.font = UIFont.systemFont(ofSize: 17)
        field.textColor = .black
        field.layer.borderWidth = 0.25
        field.backgroundColor = #colorLiteral(red: 0.96178931, green: 0.96178931, blue: 0.96178931, alpha: 1)
        field.backgroundColor = .white
        return field
    }()
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Color"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let colorTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "White"
        field.textColor = .black
        field.backgroundColor = #colorLiteral(red: 0.96178931, green: 0.96178931, blue: 0.96178931, alpha: 1)
        field.textAlignment = .right
        return field
    }()
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Size"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let sizeTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "S/M/L"
        field.backgroundColor = #colorLiteral(red: 0.96178931, green: 0.96178931, blue: 0.96178931, alpha: 1)
        field.textColor = .black
        field.textAlignment = .right
        return field
    }()
    private let usageLabel: UILabel = {
        let label = UILabel()
        label.text = "Usage status"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let usageStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("required", for: .normal)
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        return button
    }()
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "Quantity"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let quantity: UITextField = {
        let field = UITextField()
        field.placeholder = "1"
        field.backgroundColor = #colorLiteral(red: 0.96178931, green: 0.96178931, blue: 0.96178931, alpha: 1)
        field.layer.masksToBounds = true
        field.textAlignment = .right
        return field
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Sales price"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let priceTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "VND"
        field.backgroundColor = #colorLiteral(red: 0.96178931, green: 0.96178931, blue: 0.96178931, alpha: 1)
        field.layer.masksToBounds = true
        field.textAlignment = .right
        return field
    }()
    private let addVariationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        view.addSubview(addView)
        
        addView.addSubview(variationName)
        addView.addSubview(usageLabel)
        addView.addSubview(usageStatusButton)
        addView.addSubview(quantityLabel)
        addView.addSubview(quantity)
        addView.addSubview(addVariationButton)
        addView.addSubview(cancelButton)
        addView.addSubview(colorLabel)
        addView.addSubview(colorTextField)
        addView.addSubview(sizeLabel)
        addView.addSubview(sizeTextField)
        addView.addSubview(priceLabel)
        addView.addSubview(priceTextField)
        
        variationName.delegate = self
        quantity.delegate = self
        
        let menu = UIMenu(title: "Usage status", children: [
            UIAction(title: "New/Unused", handler: { action in
                self.usageStatusButton.setTitle("New/Unused", for: .normal)
                self.usageStatusButton.setTitleColor(.black, for: .normal)
                self.isButtonTapped = true
            }),
            UIAction(title: "Almost unused", handler: { action in
                self.usageStatusButton.setTitle("Almost unused", for: .normal)
                self.usageStatusButton.setTitleColor(.black, for: .normal)
                self.isButtonTapped = true
            }),
            UIAction(title: "There are no notice scratches or dirt", handler: { action in
                self.usageStatusButton.setTitle("No notice scratches or dirt", for: .normal)
                self.usageStatusButton.setTitleColor(.black, for: .normal)
                self.isButtonTapped = true
            }),
            UIAction(title: "There are some scratches or dirt", handler: { action in
                self.usageStatusButton.setTitle("Some scratches or dirt", for: .normal)
                self.usageStatusButton.setTitleColor(.black, for: .normal)
                self.isButtonTapped = true
            }),
            UIAction(title: "Scratches or dirt", handler: { action in
                self.usageStatusButton.setTitle("Scratches or dirt", for: .normal)
                self.usageStatusButton.setTitleColor(.black, for: .normal)
                self.isButtonTapped = true
            }),
            UIAction(title: "Overall bad condition", handler: { action in
                self.usageStatusButton.setTitle("Overall bad condition", for: .normal)
                self.usageStatusButton.setTitleColor(.black, for: .normal)
                self.isButtonTapped = true
            })
        ])
        usageStatusButton.menu = menu
        usageStatusButton.showsMenuAsPrimaryAction = true
        

        addView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        addView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = addView.width - 30
        variationName.frame = CGRect(x: 15, y: 25, width: size, height: 50)
        colorLabel.frame = CGRect(x: 15, y: variationName.bottom+10, width: size/2, height: 50)
        colorTextField.frame = CGRect(x: colorLabel.right, y: variationName.bottom+10, width: size/2, height: 50)
        sizeLabel.frame = CGRect(x: 15, y: colorLabel.bottom+10, width: size/2, height: 50)
        sizeTextField.frame = CGRect(x: sizeLabel.right, y: colorLabel.bottom+10, width: size/2, height: 50)
        usageLabel.frame = CGRect(x: 15, y: sizeLabel.bottom+10, width: size/2, height: 50)
        usageStatusButton.frame = CGRect(x: usageLabel.right, y: sizeLabel.bottom+10, width: size/2, height: 50)
        quantityLabel.frame = CGRect(x: 15, y: usageLabel.bottom+10, width: size/2, height: 50)
        quantity.frame = CGRect(x: quantityLabel.right+size/4, y: usageLabel.bottom+10, width: size/4, height: 50)
        priceLabel.frame = CGRect(x: 15, y: quantityLabel.bottom+10, width: size/2, height: 50)
        priceTextField.frame = CGRect(x: priceLabel.right+size/4, y: quantityLabel.bottom+10, width: size/4, height: 50)
        addVariationButton.frame = CGRect(x: 35, y: priceLabel.bottom+15, width: size-50, height: 50)
        cancelButton.frame = CGRect(x: 35, y: addVariationButton.bottom+15, width: size-50, height: 40)
        
        addVariationButton.addTarget(self, action: #selector(didTapAddVariationButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }
    
    @objc func didTapAddVariationButton() {
        if isButtonTapped, !priceTextField.text!.isEmpty {
            guard let name = variationName.text,
                    let color = colorTextField.text,
                    let size = sizeTextField.text,
                    let quantity = quantity.text!.isEmpty ? 1 : Int(quantity.text!),
                    let usageStatus = usageStatusButton.titleLabel?.text,
                    let price = Int(priceTextField.text!) else { return }
            
            delegate?.addVariationViewDidSubmitData(name: name, color: color, size: size, usageStatus: usageStatus, quantity: quantity, price: price)
            dismiss(animated: true)
        } else {
            let alertController = UIAlertController(title: "Error", message: "You must choose usage status and enter price!!", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func didTapClose() {
        dismiss(animated: true)
    }
}

extension AddVariationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
