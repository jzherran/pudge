//
//  MainContract.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation
import UIKit

protocol MainWireframe: class {
  var viewController: UIViewController! { get set }
  
  func assembleModule() -> UIViewController
  func routeLoginModule()
}

protocol MainVisualization: class {
  var presenter: MainPresentation! { get set }
  
  func loadUsers(users: [(name: String, email: String)])
}

protocol MainPresentation: class {
  var router: MainWireframe! { get set }
  var view: MainVisualization! { get set }
  var username: String! { get }
  
  func getUsers()
  func logout()
}
