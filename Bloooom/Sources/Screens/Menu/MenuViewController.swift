//
//  MenuViewController.swift
//  Bloooom
//
//  Created by Ibragim Akaev on 10/26/24.
//

import UIKit

final class MenuViewController: UIViewController {
    private let viewModel: MenuViewModel
    
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDescriptionUI()
    }
    
    private func setupDescriptionUI() {
        let label = UILabel()
        label.text = "Menu"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension MenuViewController: TabView {
    var tabInfo: Tab {
        .menu
    }
}
