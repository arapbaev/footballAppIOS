//
//  SortType.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public enum SortType: String {
    case ascending
    case descending
    
    var urlParam: String {
        switch self {
        case .ascending:
            return "asc"
        case .descending:
            return "desc"
        }
    }
}
