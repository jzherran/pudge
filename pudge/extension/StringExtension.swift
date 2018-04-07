//
//  StringExtension.swift
//  pudge
//
//  Created by Jhonatan Alexander Zambrano Herran on 4/6/18.
//  Copyright © 2018 Jhonatan Alexander Zambrano Herran. All rights reserved.
//

import Foundation

extension String {
  
  // Evaluete function for diferents types of validation
  func evaluate(with condition: String) -> Bool {
    guard let range = range(of: condition,
                            options: .regularExpression,
                            range: nil,
                            locale: nil) else {
                              return false
    }
    
    return range.lowerBound == startIndex
      && range.upperBound == endIndex
  }
}
