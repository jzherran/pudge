//
//  LoginRouter.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: LoginWireframe {

  private let serviceLocator: ServiceLocator

  var viewController: UIViewController!

  init(serviceLocator: ServiceLocator) {
    self.serviceLocator = serviceLocator
  }
  
  func assembleModule() -> UIViewController {
    let router = LoginRouter(serviceLocator: serviceLocator)
    let view = R.storyboard.login.loginScreen()
    let presenter = LoginPresenter()
    
    presenter.view = view
    presenter.router = router
    router.viewController = view
    view?.presenter = presenter
    
    return view!
  }
  
  func routeMainModule(user: String) {
    
    guard user.isNotEmpty else {
      return
    }
    
    guard let window = UIApplication.shared.delegate?.window else {
      return
    }
    
    guard let rootViewController = window?.rootViewController else {
      return
    }
    
    serviceLocator.user = user
    let mainRouter = MainRouter(serviceLocator: self.serviceLocator)
    mainRouter.viewController = mainRouter.assembleModule()
    let mainView = mainRouter.viewController
    
    mainView?.view.frame = rootViewController.view.frame
    mainView?.view.layoutIfNeeded()
    
    UIView.transition(with: window!, duration: 0.0, options: .transitionCrossDissolve, animations: {
      window?.rootViewController = UINavigationController(rootViewController: mainView!)
    })
  }
}
