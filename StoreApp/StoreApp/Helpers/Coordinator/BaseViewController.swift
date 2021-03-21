//
//  BaseViewController.swift
//  StoreApp
//
//  Created by Matheus Leandro Martins on 15/03/21.
//

import UIKit

protocol BaseViewControllerDelegate: class {
    func didMoveFromNavigationStack(_ viewController: UIViewController)
}

class BaseViewController: UIViewController {
    // MARK: - Public properties
    weak var delegate: BaseViewControllerDelegate?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
    }
}

// MARK: - UINavigationControllerDelegate
extension BaseViewController: UINavigationControllerDelegate {
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if parent == nil { delegate?.didMoveFromNavigationStack(self) }
    }
}
