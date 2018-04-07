//
//  MainController.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation
import UIKit

class MainController: UIViewController, MainVisualization, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var navigation: UINavigationItem!
  
  @IBOutlet weak var menuContainer: UIView!
  
  @IBOutlet weak var dismissContainer: UIView!
  
  @IBOutlet weak var viewMenu: UIView!
  
  @IBOutlet weak var usersTable: UITableView!
  
  @IBOutlet weak var message: UILabel!
  
  // UI Elements in hamburger menu
  @IBOutlet weak var constraintContainerWidth: NSLayoutConstraint!
  
  @IBOutlet weak var mainButton: UIButton!
  
  @IBOutlet weak var usersButton: UIButton!
  
  @IBOutlet weak var logoutButton: UIButton!
  
  @IBOutlet weak var imageView: UIView!
  
  private let maxBlackViewAlpha: CGFloat = 0.3
  
  private let maxWidthMenu: CGFloat = 0.6
  
  private var constraintMenuWidth: NSLayoutConstraint!
  
  private var constraintMenuLeft: NSLayoutConstraint!
  
  private var isOpen: Bool = false
  
  private var users: [(name: String, email: String)] = []
  
  var presenter: MainPresentation!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigation.title = presenter.username
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 5.0
    
    setupMenu()
    print("::: Set username in \(presenter.username) :::")
  }
  
  @IBAction func tapMenu(_ sender: Any) {
  }
  
  @IBAction func buttonHamburger(_ sender: Any) {
    if !isOpen {
      self.openMenu()
    } else {
      self.hideMenu()
    }
  }
  
  @IBAction func mainAction(_ sender: UIButton) {
    print("::: Main action :::")
    navigation.title = presenter.username
    message.isHidden = false
    usersTable.isHidden = true
    hideMenu()
  }
  
  @IBAction func usersAction(_ sender: UIButton) {
    presenter.getUsers()
    print("::: Users action :::")
  }
  
  @IBAction func logoutAction(_ sender: UIButton) {
    presenter.logout()
    print("::: Logout action :::")
  }
  
  @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
    self.hideMenu()
  }
  
  func loadUsers(users: [(name: String, email: String)]) {
    navigation.title = "Users"
    message.isHidden = true
    usersTable.isHidden = false
    self.hideMenu()
    self.users = users
    usersTable.reloadData()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
    let data = users[indexPath.row]
    cell.textLabel?.text = data.name
    cell.detailTextLabel?.text = data.email
    
    return cell
  }
  
  private func hideMenu() {
    isOpen = false
    constraintMenuLeft.constant = -constraintMenuWidth.constant
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
      self.dismissContainer.alpha = 0
    }, completion: { (complete) in
      self.menuContainer.isHidden = true
      self.dismissContainer.isHidden = true
    })
  }
  
  private func openMenu() {
    isOpen = true
    constraintMenuLeft.constant = 0
    menuContainer.isHidden = false
    dismissContainer.isHidden = false
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
      self.dismissContainer.alpha = self.maxBlackViewAlpha
    }, completion: nil)
  }
  
  private func setupMenu() {
    let constraintMenuTop = NSLayoutConstraint(item: viewMenu, attribute: NSLayoutAttribute.top,
                                               relatedBy: NSLayoutRelation.equal, toItem: menuContainer,
                                               attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
    let constraintMenuBottom = NSLayoutConstraint(item: viewMenu, attribute: NSLayoutAttribute.bottom,
                                                  relatedBy: NSLayoutRelation.equal, toItem: menuContainer,
                                                  attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
    
    constraintMenuWidth = NSLayoutConstraint(item: viewMenu, attribute: NSLayoutAttribute.width,
                                             relatedBy: NSLayoutRelation.equal, toItem: nil,
                                             attribute: NSLayoutAttribute.width, multiplier: 1.0,
                                             constant: view.frame.width * maxWidthMenu)
    
    constraintMenuLeft = NSLayoutConstraint(item: viewMenu, attribute: NSLayoutAttribute.leading,
                                            relatedBy: NSLayoutRelation.equal, toItem: menuContainer,
                                            attribute: NSLayoutAttribute.leading, multiplier: 1.0,
                                            constant: -constraintMenuWidth.constant)
    
    menuContainer.frame.size.height = view.frame.height
    menuContainer.frame.size.width = view.frame.width * maxWidthMenu
    viewMenu.frame.size.height = view.frame.height
    viewMenu.frame.size.width = view.frame.width * maxWidthMenu
    constraintContainerWidth.constant = view.frame.width * maxWidthMenu
    menuContainer.translatesAutoresizingMaskIntoConstraints = false
    viewMenu.translatesAutoresizingMaskIntoConstraints = false
    
    menuContainer.addSubview(viewMenu)
    menuContainer.addConstraints([constraintMenuLeft, constraintMenuTop, constraintMenuBottom])
    viewMenu.addConstraints([constraintMenuWidth])
    
    menuContainer.isHidden = true
    dismissContainer.alpha = 0
    dismissContainer.isHidden = true
    dismissContainer.backgroundColor = UIColor.black
    
    self.view.setNeedsUpdateConstraints()
    self.view.layoutIfNeeded()
  }
}
