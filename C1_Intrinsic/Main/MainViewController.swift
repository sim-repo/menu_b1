import UIKit


protocol FilterDelegateProtocol {
    func didRemoveFilter(for cell: FilterCollectionViewCell)
}

protocol SideMenuDelegateProtocol {
    func didSelectMenuItem(menuItem: MenuItem)
}



class MainViewController: UIViewController {

    var menues = Menu.list()
    var selectedFilters = [MenuItem]()
    
    
    @IBOutlet weak var sideMenu: SideMenuTableView!
    @IBOutlet weak var menuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuEdgeView: UIView!
    @IBOutlet weak var topMenuCollectionView: UICollectionView!
    @IBOutlet weak var selectedFilterCollectionView: UICollectionView!
    @IBOutlet weak var selectedFilterCollectionViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.sideMenuDelegate = self
        selectedFilterCollectionViewHeightConstraint.constant = 0
        
        sideMenu.setup(menues: menues,
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
        return sideMenu.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenu.numberRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sideMenu.cellForRowAt(indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sideMenu.viewForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Heee"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sideMenu.didSelectRowAt(didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        sideMenu.cellwillDisplay(willDisplay: cell, forRowAt: indexPath)
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
            cell.setup(menuItem: selectedFilters[indexPath.row])
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    private func showFilterMenu(show: Bool) {
        if show && selectedFilterCollectionViewHeightConstraint.constant == 0 {
            selectedFilterCollectionViewHeightConstraint.constant = 30
        }
        if !show && selectedFilters.count == 0 {
            UIView.animate(withDuration: 0.5){[weak self] in
                self?.selectedFilterCollectionViewHeightConstraint.constant = 0
                self?.view.layoutIfNeeded()
            }
        }
    }
}


extension MainViewController: FilterDelegateProtocol {

    func didRemoveFilter(for cell: FilterCollectionViewCell) {
        if let index = selectedFilterCollectionView.indexPath(for: cell) {
            selectedFilters.remove(at: index.row)
            showFilterMenu(show: false)
            if let menuItem = cell.menuItem {
                sideMenu.deselectMenuItem(menuItem: menuItem)
            }
            selectedFilterCollectionView.reloadData()
        }
    }
}


extension MainViewController: SideMenuDelegateProtocol {
    func didSelectMenuItem(menuItem: MenuItem) {
        if let _ = selectedFilters.first(where: {$0.id == menuItem.id}) {
            return
        }
        selectedFilters.append(menuItem)
        showFilterMenu(show: true)
        selectedFilterCollectionView.reloadData()
    }
}
