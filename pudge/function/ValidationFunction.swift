//
//  ValidationFunction.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation

private let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]{2,64}\\.[A-Za-z]{2,64}$"

/// Function for validating if a String is an email
public func isValidEmail(_ email: String) -> Bool {
  return email.evaluate(with: emailRegex)
}
