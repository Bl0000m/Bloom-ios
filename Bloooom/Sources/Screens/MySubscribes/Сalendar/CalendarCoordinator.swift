import UIKit

final class CalendarCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var month: String?
    let subscribeName: String
    let subscribeType: String
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, subscribeName: String, subscribeType: String) {
        self.navigationController = navigationController
        self.subscribeName = subscribeName
        self.subscribeType = subscribeType
    }
    
    func start() {
        let viewModel = CalendarViewModel(coordinator: self)
        let viewController = CalendarViewController(viewModel: viewModel)
        viewController.month = month
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goCalendar() {
        let coordinator = MonthsCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToOrderDetails(data: [Date]) {
        let coordinator = OrderDetailsCoordinator(
            navigationController: navigationController,
            monthNames: data,
            subsrcibeName: subscribeName,
            subscribeType: subscribeType
        )
        childCoordinators.append(coordinator)
        coordinator.start()
    }

//    func goToOrderDetails(data: [String]) {
//        let coordinator = OrderDetailsCoordinator(
//            navigationController: navigationController,
//            monthNames: data,
//            subsrcibeName: subscribeName,
//            subscribeType: subscribeType
//        )
//        childCoordinators.append(coordinator)
//        coordinator.start()
//    }
}
