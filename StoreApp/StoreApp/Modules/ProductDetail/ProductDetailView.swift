//
//  ProductDetailView.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

protocol ProductDetailViewDelegate: class {
    func didTapOnSubmitButton()
}

final class ProductDetailView: UIView {
    //MARK: - Private properties
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let productImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let infosStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private let productName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let productQuantity: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let productCondition: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .blue
        button.setTitle("See more details", for: .normal)
        button.addTarget(self, action: #selector(didSubmit), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Public methods
    weak var delegate: ProductDetailViewDelegate?
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    @objc private func didSubmit() {
        delegate?.didTapOnSubmitButton()
    }
    
    //MARK: - Public methods
    func setupView(with model: ProductModel) {
        productName.text = model.title
        productPrice.text = "Price: \(model.price)"
        productQuantity.text = "Quantity available: \(model.availableQuantity)"
        productCondition.text = "Product Condition: \(model.condition)"
        productImage.startAnimating()
        setupViewConfiguration()
    }
    
    func setupImage(image: Data?, hasError: Bool) {
        if hasError { productImage.tintColor = .black }
        productImage.hideLoading()
        productImage.image = hasError ? UIImage(named: "notFoundICon") : UIImage(data: image ?? Data())
    }
}


extension ProductDetailView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [scrollView])
        scrollView.addSubviews(views: [infosStackView])
        infosStackView.addArrangedSubviews(views: [
            productImage,
            productName,
            productPrice,
            productQuantity,
            productCondition,
            submitButton
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //scrollView
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            //productImage
            productImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 200),
            productImage.widthAnchor.constraint(equalToConstant: 200),
            
            //submitButton
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            
            //infosStackView
            infosStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            infosStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            infosStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            infosStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
            infosStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
        
    }
}
