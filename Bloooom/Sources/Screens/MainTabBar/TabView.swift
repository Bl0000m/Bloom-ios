//
//  TabView.swift
//  Bloooom
//
//  Created by Ibragim Akaev on 10/26/24.
//

import Foundation

protocol TabView {
    var tabInfo: Tab { get }
}

enum Tab: Int {
    case home, search, menu, basket, profile
    
    var image: String {
        switch self {
        case .home: "home"
        case .search: "search"
        case .menu: "menu"
        case .basket: "bag"
        case .profile: "user"
        }
    }
}
