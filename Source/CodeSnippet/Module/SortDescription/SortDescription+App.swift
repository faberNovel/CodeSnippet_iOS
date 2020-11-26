//
//  SortDescription+App.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 26/11/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import Foundation

struct MyEntity {
    let id: String
    let name: String
    let age: Int
}

struct PerNameMyEntitySortDescription: SortDescription {

    func areInIncreasingOrder(_ lhs: MyEntity, _ rhs: MyEntity) -> Bool {
        [lhs.name, lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.name, rhs.id])
    }
}

struct PerAgeMyEntitySortDescription: SortDescription {

    func areInIncreasingOrder(_ lhs: MyEntity, _ rhs: MyEntity) -> Bool {
        if lhs.age == rhs.age {
            return [lhs.id].isInLocalizedIncreasingOrder(comparedTo: [rhs.id])
        }
        return lhs.age < rhs.age
    }
}
