import UIKit

class SelfSizedTableView: UITableView {
    
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    var deniedReload = false
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
    
    override func reloadData() {
        guard deniedReload == false else { return }
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
}

