//
//  MainPresenter.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MainPresenter: MainPresentation {
  
  private let url: String = "http://162.243.254.239/users.json"
  
  var router: MainWireframe!
  
  var view: MainVisualization!
  
  var username: String!
  
  init(username: String) {
    self.username = username
  }
  
  func getUsers() {
    var users: [(name: String, email: String)] = []
    
    Alamofire.request(url).responseJSON { response in
      if let data = response.result.value {
        let json = JSON(data)
        for user in json.array! {
          users.append((name: user["nombre"].stringValue, email: user["email"].stringValue))
        }
      }
      
      self.view.loadUsers(users: users)
    }
  }
  
  func logout() {
    router.routeLoginModule()
  }
}
