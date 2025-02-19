import UIKit

class VerifyProfileViewController: UIViewController {

    private var viewModel: VerifyProfileViewModelProtocol
    
    private let navBar = CustomNavBar()
    private let profileTableView: UITableView = {
        let table = UITableView()
        table.separatorColor = .clear
        table.isScrollEnabled = false
        table.register(VerifyProfileCell.self, forCellReuseIdentifier: VerifyProfileCell.verifyProfileID)
        table.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.headerID)
        table.register(FooterView.self, forHeaderFooterViewReuseIdentifier: FooterView.footerID)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupTableExtensions()
        bindViewModel() 
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    init(viewModel: VerifyProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(profileTableView)
        view.addSubview(navBar)
    }
    
    private func removeData() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: "userName")
        defaults.removeObject(forKey: "userPhoneNumber")
        defaults.removeObject(forKey: "userEmail")
    }
    
    private func setupLayout() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            navBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableExtensions() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.fetchData()
    }
}

extension VerifyProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VerifyProfileCell.verifyProfileID, for: indexPath) as? VerifyProfileCell else { return UITableViewCell() }
        let item = viewModel.items[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(for: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.headerID) as? HeaderView else {
            return UITableViewHeaderFooterView()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: FooterView.footerID
        ) as? FooterView else {
            return UITableViewHeaderFooterView()
        }
        
        footerView.closeSessionClosure = { [weak self] in
            self?.viewModel.closeSession()
            self?.viewModel.removeUser()
            KeychainManager.shared.handleFirstLaunch()
            self?.removeData()
            self?.viewModel.onLogoutSuccess = {
                DispatchQueue.main.async {
                    self?.viewModel.goToSignIn()
                }
            }
            
            self?.viewModel.onLogoutFailure = { error in
                print(error)
            }
        }
        
        footerView.deleteUserClosure = { [weak self] in
            self?.viewModel.removeUser()
            KeychainManager.shared.handleFirstLaunch()
            self?.removeData()
            self?.viewModel.onLogoutSuccess = {
                DispatchQueue.main.async {
                    self?.viewModel.goToSignIn()
                }
            }
            
            self?.viewModel.onLogoutFailure = { error in
                print(error)
            }
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
}

extension VerifyProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            viewModel.moveToSubscribes()
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        default:
            break
        }
    }
}

extension VerifyProfileViewController: TabView {
    var tabInfo: Tab {
        .verifyProfile
    }
    
    
}
