//___FILEHEADER___

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
