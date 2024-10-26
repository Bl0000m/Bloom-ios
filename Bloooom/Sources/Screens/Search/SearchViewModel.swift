import Foundation

final class SearchViewModel {
    private weak var coordinator: SearchViewCoordinator?
    
    init(coordinator: SearchViewCoordinator?) {
        self.coordinator = coordinator
    }
}
