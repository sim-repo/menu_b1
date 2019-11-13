import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterLabel: UILabel!
    
    var mainViewControllerDelegate: MainViewControllerDelegate?
    
    @IBAction func doRemoveFilter(_ sender: Any) {
        if let idx = mainViewControllerDelegate?.getIndexPath(for: self) {
            mainViewControllerDelegate?.removeFilter(indexPath: idx)
        }
    }
}
