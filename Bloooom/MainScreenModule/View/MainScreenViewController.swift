//
//  ViewController.swift
//  Bloooom
//
//  Created by Niyazov Makhmujan on 03.10.2024.
//

import UIKit

class MainScreenViewController: UIViewController {

  private let screensArray = ["1", "2", "3", "4"]
  private let logosArray = ["logo1", "logo2", "logo3", "logo4"]
  
  private let mainScreenTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(MainScreenCell.self, forCellReuseIdentifier: MainScreenCell.screenID)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setElementToView()
    setConstraints()
    let navBar = UINavigationBar.appearance()
    navBar.tintColor = #colorLiteral(red: 0.9058821797, green: 0.9058825374, blue: 0.9144912362, alpha: 1)
  }

  private func setElementToView() {
    view.addSubview(mainScreenTableView)
    mainScreenTableView.delegate = self
    mainScreenTableView.dataSource = self
    mainScreenTableView.showsVerticalScrollIndicator = false
    mainScreenTableView.showsHorizontalScrollIndicator = false
  }

  private func setConstraints() {
    NSLayoutConstraint.activate([
      mainScreenTableView.topAnchor.constraint(equalTo: view.topAnchor),
      mainScreenTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mainScreenTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mainScreenTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension MainScreenViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return screensArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenCell.screenID,
                                                   for: indexPath) as? MainScreenCell else {
      return UITableViewCell()
    }
    let image = screensArray[indexPath.row]
    let logo = logosArray[indexPath.row]
    cell.configure(screenImg: image, logoImg: logo)
    return cell
  }
}

extension MainScreenViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UIScreen.main.bounds.height
  }
}
