//
//  PersonListViewModel.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 27/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import Foundation

struct PersonRowViewModel: Identifiable, Equatable {
    let id: ViewID
    let name: String
}

struct PersonListViewModel {

    typealias List = ListViewModel<VoidHeaderViewModel, PersonRowViewModel>

    let list: List
}
