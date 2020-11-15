//
//  ListProductsView.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

final class ListProductsView: UIView {
    //MARK: - Private properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Initialization
    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: .zero)
        setupTableView(delegate: delegate, dataSource: dataSource)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
    }
    
    //MARK: - Public methods
    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: - ViewConfiguration
extension ListProductsView: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [tableView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
