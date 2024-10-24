import UIKit

class CreateAccountViewController: UIViewController {
  
  private var createAccountViewModel: CreateAccountViewModelProtocol
  private var createAccountCoordinator: CreateAccountCoordinator
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
  
  init(createAccountViewModel: CreateAccountViewModelProtocol, createAccountCoordinator: CreateAccountCoordinator) {
    self.createAccountViewModel = createAccountViewModel
    self.createAccountCoordinator = createAccountCoordinator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
