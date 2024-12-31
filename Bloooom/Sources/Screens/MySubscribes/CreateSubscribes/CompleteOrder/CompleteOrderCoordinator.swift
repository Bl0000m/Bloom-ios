import UIKit

final class CompleteOrderCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let transitionDelegate = CenterTransitioningDelegate()
    let monthNames: [Date]
    let subsrcibeName: String
    let subscribeType: String
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, monthNames: [Date], subsrcibeName: String, subscribeType: String) {
        self.navigationController = navigationController
        self.subsrcibeName = subsrcibeName
        self.subscribeType = subscribeType
        self.monthNames = monthNames
    }
    
    func start() {
        
    }
}


