//
//  Season+Extension.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/24/22.
//

import Foundation
import Core

extension Season {
    static func mock() -> Season {
        return Season(year: 2021, startDate: Date(), endDate: Date(), displayName: "2021-22 English Premier League")
    }
}
