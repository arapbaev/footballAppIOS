//
//  ErrorMessage.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

public struct ErrorMessage: Error {

  // MARK: - Properties
  public let id: UUID
  public let title: String
  public let message: String

  // MARK: - Methods
  public init(title: String, message: String) {
    self.id = UUID()
    self.title = title
    self.message = message
  }
}
