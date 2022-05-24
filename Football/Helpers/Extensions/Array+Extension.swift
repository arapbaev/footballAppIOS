//
//  Array+Extension.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/24/22.
//

import Core

extension Array where Element == Stat {
    func getStatValue(type: StatType) -> String {
        return self.first { $0.type == type }?.displayValue ?? "0"
    }
}
