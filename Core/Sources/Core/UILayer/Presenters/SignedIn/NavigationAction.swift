//
//  NavigationAction.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

public enum NavigationAction<PresenterType>: Equatable where PresenterType: Equatable {
  case present(view: PresenterType)
  case presented(view: PresenterType)
}
