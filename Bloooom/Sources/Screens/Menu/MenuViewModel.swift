import Foundation

final class MenuViewModel {
    private weak var coordinator: MenuViewCoordinator?
    
    init(coordinator: MenuViewCoordinator?) {
        self.coordinator = coordinator
    }
}
