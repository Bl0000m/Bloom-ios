import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    
    func start()
    func childDidFinish(_ childCoordinator: Coordinator)
}

extension Coordinator {
    var navigationController: UINavigationController { .init() }
    
    func childDidFinish(_ childCoordinator: Coordinator) {}
}
