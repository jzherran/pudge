//
//  ViewController.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import UIKit
import PasswordTextField

class LoginController: UIViewController, LoginVisualization {

  // Containers
  @IBOutlet weak var scrollView: UIScrollView!

  @IBOutlet weak var contentView: UIView!

  // Elements
  @IBOutlet weak var emailTextfield: UITextField!

  @IBOutlet weak var passwordTextfield: PasswordTextField!

  @IBOutlet weak var loginButton: UIButton!

  @IBOutlet weak var icon: UIView!

  // Constraints
  @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!

  // Internal variables
  var activeField: UITextField?

  var keyboardHeight: CGFloat!

  var presenter: LoginPresentation!

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                           name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                           name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    // Add touch gesture for contentView
    self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(returnTextField(gesture:))))
  }

  @objc func returnTextField(gesture: UIGestureRecognizer) {
    guard activeField != nil else {
      return
    }

    activeField?.resignFirstResponder()
    activeField = nil
  }

  // Actions for UI elements
  @IBAction func loginAction(_ sender: UIButton) {
    activeField?.resignFirstResponder()
    presenter.login(user: emailTextfield.text ?? "", password: passwordTextfield.text ?? "")
  }

  func showError(message: String, isAlert: Bool? = false) {
    guard isAlert! else {
      print("::: Error \(message) :::")
      return
    }

    let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true)
  }

  private func setup() {
    emailTextfield.delegate = self
    passwordTextfield.delegate = self

    loginButton.layer.cornerRadius = 5.0
    loginButton.clipsToBounds = true

    icon.layer.cornerRadius = 75.0
    createIcon()
  }

  private func createIcon() {
    let width: CGFloat = self.icon.frame.size.width / 2
    let height: CGFloat = (self.icon.frame.size.height - 10) / 2

    let path1 = UIBezierPath()
    path1.move(to: CGPoint(x: width / 2, y: 10.0))
    path1.addLine(to: CGPoint(x: 0.0, y: height))
    path1.addLine(to: CGPoint(x: width, y: height))
    path1.close()

    let path2 = UIBezierPath()
    path2.move(to: CGPoint(x: width / 2, y: height))
    path2.addLine(to: CGPoint(x: 0.0, y: 0.0))
    path2.addLine(to: CGPoint(x: width, y: 0.0))
    path2.close()

    let shapeLayer1 = CAShapeLayer()
    shapeLayer1.path = path1.cgPath
    shapeLayer1.fillColor = UIColor.white.cgColor
    shapeLayer1.position = CGPoint(x: width / 2, y: 0.0)

    let shapeLayer2 = CAShapeLayer()
    shapeLayer2.path = path2.cgPath
    shapeLayer2.fillColor = UIColor.black.cgColor
    shapeLayer2.position = CGPoint(x: width / 2, y: height)

    self.icon.layer.addSublayer(shapeLayer1)
    self.icon.layer.addSublayer(shapeLayer2)
  }
}

extension LoginController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    activeField = textField
    return true
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    activeField?.resignFirstResponder()
    activeField = nil
    return true
  }
}

extension LoginController {

  @objc func keyboardWillShow(notification: NSNotification) {
    if keyboardHeight != nil {
      return
    }

    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      keyboardHeight = keyboardSize.height

      // So increase contentView's height by keyboard height
      UIView.animate(withDuration: 0.3, animations: {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardHeight, right: 0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets

        // Move scroll to active field
        guard let field = self.activeField else {
          return
        }

        if abs(self.keyboardHeight - field.frame.maxY + 10) < 10 {
          self.scrollView.contentOffset = CGPoint(x: 0, y: self.keyboardHeight)
        }
      })
    }
  }

  @objc func keyboardWillHide(notification: NSNotification) {

    UIView.animate(withDuration: 0.3) {
      self.scrollView.contentInset = .zero
      self.scrollView.scrollIndicatorInsets = .zero
    }

    keyboardHeight = nil
  }
}

