import Foundation

final class BasketViewModel {
    private weak var coordinator: BasketViewCoordinator?
    
    init(coordinator: BasketViewCoordinator?) {
        self.coordinator = coordinator
    }
}
