//
//  SortDescription.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

struct SortDescription<T> {

    let areInIncreasingOrder: (T, T) -> Bool
}
