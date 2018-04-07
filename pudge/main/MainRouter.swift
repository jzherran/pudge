//
//  MainRouter.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: MainWireframe {
  
  private let serviceLocator: ServiceLocator
  
  var viewController: UIViewController!
  
  init(serviceLocator: ServiceLocator) {
    self.serviceLocator = serviceLocator
  }
  
  func assembleModule() -> UIViewController {
    let router = MainRouter(serviceLocator: serviceLocator)
    let view = R.storyboard.main.mainScreen()
    let presenter = MainPresenter(username: serviceLocator.user!)
    
    presenter.view = view
    presenter.router = router
    router.viewController = view
    view?.presenter = presenter
    
    return view!
  }
  
  func routeLoginModule() {
    serviceLocator.user = nil
    
    guard let window = UIApplication.shared.delegate?.window else {
      return
    }
    
    guard let rootViewController = window?.rootViewController else {
      return
    }
    
    let loginRouter = LoginRouter(serviceLocator: self.serviceLocator)
    loginRouter.viewController = loginRouter.assembleModule()
    let loginView = loginRouter.viewController
    
    loginView?.view.frame = rootViewController.view.frame
    loginView?.view.layoutIfNeeded()
    
    UIView.transition(with: window!, duration: 0.0, options: .transitionCrossDissolve, animations: {
      window?.rootViewController = loginView!
    })
  }
}
