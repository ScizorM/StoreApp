//
//  ProductCell.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

class ProductCell: UITableViewCell {
    //MARK: - Private properties
    private let productImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let productName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    //MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    //MARK: - Public methods
    func setupInfos(with product: ProductModel) {
        productImage.image = nil
        productName.text = product.title
        productImage.showLoading()
        setupViewConfiguration()
    }
    
    func setupImage(image: Data, hasError: Bool) {
        if hasError { productImage.tintColor = .black }
        productImage.hideLoading()
        productImage.image = hasError ? UIImage(named: "notFoundICon") : UIImage(data: image)
    }
}

//MARK: - ViewConfiguration
extension ProductCell: ViewConfiguration {
    func buildHierarchy() {
         addSubviews(views: [productImage, productName])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //productImage
            productImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productImage.trailingAnchor.constraint(equalTo: productName.leadingAnchor, constant: -16),
            productImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            productImage.widthAnchor.constraint(equalToConstant: 100),
    
            //productName
            productName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            productName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            productName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
}


