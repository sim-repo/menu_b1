import UIKit

class MainViewController: UIViewController {

    var menues = Menu.list()
    var selectedFilters = [String]()
    
    
    @IBOutlet weak var menuTableView: MenuTableView!
    @IBOutlet weak var menuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuEdgeView: UIView!
    @IBOutlet weak var topMenuCollectionView: UICollectionView!
    @IBOutlet weak var selectedFilterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.mainViewControllerDelegate = self
        
        menuTableView.setup(menues: menues,
                            nibName: "TableViewCell",
                            cellId: "Cell",
                            menuWidthConstraint: menuWidthConstraint,
                            menuEdgeView: menuEdgeView,
                            containerView: view)
    }
}



//MARK:- Table View Datasource

extension MainViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuTableView.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTableView.numberRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return menuTableView.cellForRowAt(indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return menuTableView.viewForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Heee"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.didSelectRowAt(didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        menuTableView.cellwillDisplay(willDisplay: cell, forRowAt: indexPath)
    }
}


//MARK:- Collection View Datasource



extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
         case 1000: return 10
         case 2000: return selectedFilters.count
         default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1000:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
            return cell
        case 2000:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionCell", for: indexPath) as! FilterCollectionViewCell
            cell.filterLabel.text = selectedFilters[indexPath.row]
            cell.mainViewControllerDelegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


extension MainViewController: MainViewControllerDelegate {
    func didSelectMenuItem(menuItem: String) {
        if let _ = selectedFilters.first(where: {$0 == menuItem}) {
            return
        }
        selectedFilters.append(menuItem)
        selectedFilterCollectionView.reloadData()
    }
    
    func removeFilter(indexPath: IndexPath) {
        selectedFilters.remove(at: indexPath.row)
        selectedFilterCollectionView.reloadData()
    }
    
    func getIndexPath(for cell: UICollectionViewCell) -> IndexPath? {
        let index = selectedFilterCollectionView.indexPath(for: cell)
        return index
    }
}
