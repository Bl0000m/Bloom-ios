import Foundation

protocol VerificationUserViewModelProtocol {
    func goBack()
    func confirmCode(email: String, code: String)
    func onMainPage()
    func resetCode(email: String)
    
    var onCodeConfirmed: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var onEmailConfimed: (() -> Void)? { get set }
    var onEmailError: ((String) -> Void)? { get set }
}

class VerificationUserViewModel: VerificationUserViewModelProtocol {
  
    private weak var verificationUserCoordinator: VerificationUserCoordinator?
    
    var onError: ((String) -> Void)?
    var onCodeConfirmed: (() -> Void)?
    var onEmailConfimed: (() -> Void)?
    var onEmailError: ((String) -> Void)?
    
    init(verificationUserCoordinator: VerificationUserCoordinator?) {
        self.verificationUserCoordinator = verificationUserCoordinator
    }
    
    func goBack() {
        verificationUserCoordinator?.backButtonAction()
    }
    
    func confirmCode(email: String, code: String) {        
        UserAPIManager.shared.confirmCode(email: email, code: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onCodeConfirmed?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func resetCode(email: String) {
        UserAPIManager.shared.resetCode(email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onEmailConfimed?()
                case .failure(let failure):
                    self?.onEmailError?(failure.localizedDescription)
                }
            }
        }
    }
    
    func onMainPage() {
        verificationUserCoordinator?.successVerification()
    }
    
}
