//
//  BaseCoordinator.swift
//  StoreApp
//
//  Created by Matheus Leandro Martins on 12/03/21.
//

import UIKit

protocol BaseCoordinatorParentDelegate: class {
    func didFinish(coordinator: BaseCoordinator)
}

class BaseCoordinator: NSObject {
    
    // MARK: - Private properties

    internal var identifier: String { return String(describing: self) }
    internal var childCoordinator = [String: BaseCoordinator]()
    
    weak var parent: BaseCoordinatorParentDelegate?
    
    // MARK: -
    var rootViewController: BaseViewController? {
        didSet {
            rootViewController?.delegate = self
        }
    }
    
    // MARK: - Public methods
    func start() {
        fatalError("Start method should be implemented.")
    }

    func coordinate(to coordinator: BaseCoordinator, parent: BaseCoordinator) {
        store(coordinator)
        coordinator.parent = parent
        coordinator.start()
    }
    
    // MARK: - Private methods
    private func store(_ coordinator: BaseCoordinator) {
        childCoordinator[coordinator.identifier] = coordinator
    }
    
    private func free(_ coordinator: BaseCoordinator) {
        childCoordinator[coordinator.identifier] = nil
    }
}

// MARK: - BaseCoordinatorParentDelegate
extension BaseCoordinator: BaseCoordinatorParentDelegate {
    func didFinish(coordinator: BaseCoordinator) {
        free(coordinator)
    }
}

// MARK: - BaseViewControllerDelegate
extension BaseCoordinator: BaseViewControllerDelegate {
    func didMoveFromNavigationStack(_ viewController: UIViewController) {
        guard rootViewController === viewController else { return }
        parent?.didFinish(coordinator: self)
    }
}
