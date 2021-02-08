//
//  SortDescription+App.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 26/11/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import Foundation

struct Person {
    let id: String
    let name: String
    let age: Int
}

extension SortDescription where T == Person {

    static func perName() -> SortDescription {
        SortDescription { lhs, rhs in
            [lhs.name, lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.name, rhs.id])
        }
    }

    static func perAge() -> SortDescription {
        SortDescription { lhs, rhs in
            if lhs.age == rhs.age {
                return [lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.id])
            }
            return lhs.age < rhs.age
        }
    }
}
