//
//  AutoSizingCollectionView.swift
//  CodeSnippet
//
//  Created by Gaétan Zanella on 28/01/2021.
//  Copyright © 2021 Zanella. All rights reserved.
//

import UIKit

class AutoSizingCollectionView: UICollectionView {

    // MARK: - Life Cycle

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    // MARK: - UIView

    override var intrinsicContentSize: CGSize {
        return contentSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }

    // MARK: - Private

    private func setUp() {
        isScrollEnabled = false
    }
}
