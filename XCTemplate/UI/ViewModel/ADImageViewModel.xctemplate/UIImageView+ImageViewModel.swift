//___FILEHEADER___

import UIKit

extension UIImageView {

    func <#prefix#>_configure(for viewModel: ImageViewModel) {
        switch viewModel.origin {
        case .bundle:
            image = viewModel.uiImage
        case .distantURL:
            <#SDWebImage / Nuke / KingFisher …#>
        }
    }
}
