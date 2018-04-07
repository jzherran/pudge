//
//  LoginContract.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation
import UIKit

protocol LoginWireframe: class {
  var viewController: UIViewController! { get set }

  func assembleModule() -> UIViewController
  func routeMainModule(user: String)
}

protocol LoginVisualization: class {
  var presenter: LoginPresentation! { get set }

  func showError(message: String, isAlert: Bool?)
}

protocol LoginPresentation: class {
  var router: LoginWireframe! { get set }
  var view: LoginVisualization! { get set }

  func login(user: String, password: String)
}
