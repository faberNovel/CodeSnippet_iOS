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

struct PerNamePersonSortDescription: SortDescription {

    func areInIncreasingOrder(_ lhs: Person, _ rhs: Person) -> Bool {
        [lhs.name, lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.name, rhs.id])
    }
}

struct PerAgePersonSortDescription: SortDescription {

    func areInIncreasingOrder(_ lhs: Person, _ rhs: Person) -> Bool {
        if lhs.age == rhs.age {
            return [lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.id])
        }
        return lhs.age < rhs.age
    }
}
