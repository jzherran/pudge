//
//  LoginRouter.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter: LoginPresentation {
  
  var router: LoginWireframe!
  
  var view: LoginVisualization!
  
  func login(user: String, password: String) {
    guard password.isNotEmpty else {
      print("::: Invalid PASSWORD :::")
      return
    }
    
    guard isValidEmail(user) else {
      print("::: Invalid EMAIL :::")
      view.showError(message: "Email not is valid, please change and try again!", isAlert: true)
      return
    }
    
    print("::: Login SUCCESSFUL :::")
    router.routeMainModule(user: user)
  }
}
