import Foundation

protocol MonthsViewModelProtocol {
   // func selectedMonth(month: String)
}

class MonthsViewModel: MonthsViewModelProtocol {
    
    private let coordinator: MonthsCoordinator
    
    init(coordinator: MonthsCoordinator) {
        self.coordinator = coordinator
    }
    
//    func selectedMonth(month: String) {
//        coordinator.setMonthTitle(month: month)
//    }

}
