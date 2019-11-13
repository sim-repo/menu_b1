import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterLabel: UILabel!
    
    var menuItem: MenuItem?
    
    var delegate: FilterDelegateProtocol?
    
    func setup(menuItem: MenuItem) {
        self.menuItem = menuItem
        filterLabel.text = menuItem.title
    }
    
    @IBAction func doRemoveFilter(_ sender: Any) {
        delegate?.didRemoveFilter(for: self)
    }
}
