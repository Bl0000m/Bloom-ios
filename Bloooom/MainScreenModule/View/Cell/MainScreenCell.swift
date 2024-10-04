//
//  MainScreenCell.swift
//  Bloooom
//
//  Created by Niyazov Makhmujan on 04.10.2024.
//

import UIKit

class MainScreenCell: UITableViewCell {

  static let screenID = "screnID"
  
  private let screenImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let logoImage: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private lazy var searchButton: UIButton = {
    let button = UIButton()
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addElementsToView()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addElementsToView() {
    addSubview(screenImage)
    addSubview(logoImage)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      screenImage.topAnchor.constraint(equalTo: topAnchor),
      screenImage.leadingAnchor.constraint(equalTo: leadingAnchor),
      screenImage.trailingAnchor.constraint(equalTo: trailingAnchor),
      screenImage.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 95),
      logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
      logoImage.heightAnchor.constraint(equalToConstant: 153)
    ])
  }
  
  func configure(screenImg: String, logoImg: String) {
    screenImage.image = UIImage(named: screenImg)
    logoImage.image = UIImage(named: logoImg)
  }
  
}
