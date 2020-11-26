//
//  SortDescription.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 26/11/2020.
//  Copyright © 2020 Zanella. All rights reserved.
//

import Foundation

protocol SortDescription {

    associatedtype Element

    func areInIncreasingOrder(_ lhs: Element, _ rhs: Element) -> Bool
}
