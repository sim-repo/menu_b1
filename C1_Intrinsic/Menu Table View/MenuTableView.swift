import UIKit


protocol MainViewControllerDelegate {
    func didSelectMenuItem(menuItem: String)
    func removeFilter(indexPath: IndexPath)
    func getIndexPath(for cell: UICollectionViewCell) -> IndexPath? 
}

protocol MenuTableViewDelegate {
    func scrollUp()
}


class MenuTableView: SelfSizedTableView {
    
    var menues: [Menu]!
    
    
    var deepIndexSection = -1
    var idx2realIdx = [IndexPath: IndexPath]()
    var selected = [Int:Menu]()
    
    var menuWidthConstraint: NSLayoutConstraint!
    var menuOriginalWidth: CGFloat = 0.0
    var menuExpandedWidth: CGFloat = 0.0
    var menuHiddenWidth: CGFloat = 0.0
    var menuEdgeView: UIView!
    
    let gestureRecognizer = UIPanGestureRecognizer()
    var startLocation = CGPoint()
    var expanded = false
    
    var menuSwipeAnimationInProgress = false
    var clickMenuItemAnimation = false
    
    var idxPaths = [Int:[IndexPath]]()
    
    var rowsInSection = [Int:Int]()
    
    var containerView: UIView!
    
    var mainViewControllerDelegate: MainViewControllerDelegate?
    
    
    
    func setup(menues: [Menu], nibName: String, cellId: String, menuWidthConstraint: NSLayoutConstraint, menuEdgeView: UIView, containerView: UIView!){
        
        self.menues = menues
        self.menuWidthConstraint = menuWidthConstraint
        self.menuEdgeView = menuEdgeView
        self.menuOriginalWidth = 0
        self.menuExpandedWidth = menuWidthConstraint.multiplier * containerView.frame.size.width - 20
        self.menuHiddenWidth = -menuWidthConstraint.multiplier * containerView.frame.size.width 
        
        self.containerView = containerView
        
        maxHeight =  UIScreen.main.bounds.size.height
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44
        isScrollEnabled = false
        separatorStyle = .none
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellId)
        register(UINib(nibName: "TableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "TableViewHeader")
        idx2realIdx[IndexPath(row: -1, section: 0)] = IndexPath(row: -1, section: 0)
        addMenuSection(indexPath: IndexPath(row: -1, section: 0))
        
        self.menuEdgeView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.addTarget(self, action: #selector(handlePanGesture(_:)))
    }
    
    
    public func numberOfSections() -> Int {
        return deepIndexSection + 1
    }
    
    
    public func numberRowsInSection(section: Int) -> Int {
        return selected[section]?.menuItems.count ?? 1
    }
    
    public func cellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let c = dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        if let menu = selected[indexPath.section],
            let item = menu.menuItems[indexPath.row] {
            c.setup(text: item)
            c.changeTextSize(expanded: expanded)
        }
        return c
    }
    
    public func viewForHeaderInSection(section: Int) -> UIView {
        let headerView = dequeueReusableHeaderFooterView(withIdentifier: "TableViewHeader") as! TableViewHeader
        if let menu = selected[section] {
            headerView.titleLabel.text = menu.title
        }
        headerView.delegate = self
        if contentSize.height < UIScreen.main.bounds.size.height {
            headerView.upButton.alpha = 0
        }
        return headerView
        
        
//        let hview = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: 20))
//        hview.backgroundColor = #colorLiteral(red: 0.01456308831, green: 0.07495442778, blue: 0.1589405835, alpha: 1)
//        if let menu = selected[section] {
//            let label = UILabel(frame: CGRect(x: 10, y: 7, width: containerView.frame.size.width, height: 20))
//            label.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//            label.text = menu.title
//            hview.addSubview(label)
//        }
//        return hview
    }
    
    public func didSelectRowAt(didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
        clickMenuItemAnimation = true
        addMenuSection(indexPath: indexPath)
        
        if let item = getMenuItem(indexPath: indexPath) {
            mainViewControllerDelegate?.didSelectMenuItem(menuItem: item)
        }
    }
    
    
    public func cellwillDisplay(willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       if clickMenuItemAnimation {
           animateIn(cell: cell, withDelay: 0.1 * Double(indexPath.row))
       }
    }
    

    private func getMenuItem(indexPath: IndexPath) -> String? {
        if let menu = selected[indexPath.section],
            menu.isFilter,
            let item = menu.menuItems[indexPath.row] {
             return item
        }
        return nil
    }
    
    private func animateIn(cell: UITableViewCell, withDelay delay: TimeInterval) {
         let initialScale: CGFloat = 1.2
         let duration: TimeInterval = 0.5
         
         cell.alpha = 0.0
         cell.layer.transform = CATransform3DMakeScale(initialScale, initialScale, 1)
         UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
             cell.alpha = 1.0
             cell.layer.transform = CATransform3DIdentity
         }, completion: nil)
   }
}







extension MenuTableView {
    
    
//MARK:- Menu Edge Actions
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        
        clickMenuItemAnimation = false
        
        switch recognizer.state {
            case .began:
                if startLocation.x == 0 {
                    startLocation = recognizer.location(in: menuEdgeView)
                }
            case .changed:
                guard !menuSwipeAnimationInProgress else { return }
                let currLocation = recognizer.location(in: menuEdgeView)
                let dx = currLocation.x - startLocation.x
                switch recognizer.direction {
                    case .right:
                        gestureToRight(dx: dx)
                           
                    case .left:
                        gestureToLeft(dx: dx)
                    
                    default: return
                }
            break
            
        case .ended:
            self.startLocation.x = 0
            if menuSwipeAnimationInProgress == false {
                UIView.animate(withDuration: 0.5){
                    self.menuWidthConstraint.constant = self.expanded ? self.menuExpandedWidth : self.menuOriginalWidth
                    self.containerView.layoutIfNeeded()
                }
            }
        default: return
        }
    }
    
    
    //expand
    private func gestureToRight(dx: CGFloat){
        if dx <= 40 {
           menuWidthConstraint.constant += 2
           return
        }
        menuSwipeAnimationInProgress = true
        UIView.animate(withDuration: 1.0,
                      animations: { [weak self] in
                        guard let self = self else { return }
                           self.expanded = true
                           self.menuWidthConstraint.constant = self.menuExpandedWidth
                           self.containerView.layoutIfNeeded()},
                      completion: { [weak self] _ in
                           guard let self = self else { return }
                           self.doReloadRows()
                           self.menuSwipeAnimationInProgress = false})
    }
    
    //collapse
    private func gestureToLeft(dx: CGFloat){
        if dx >= -40 {
            menuWidthConstraint.constant -= 2
            return
        }
        menuSwipeAnimationInProgress = true
        if menuWidthConstraint.constant == menuOriginalWidth {
            hide()
            return
        }
        UIView.animate(withDuration: 1.0,
                       animations: { [weak self] in
                            guard let self = self else { return }
                            self.menuWidthConstraint.constant = self.menuOriginalWidth
                            self.containerView.layoutIfNeeded()},
                       completion: { [weak self] _ in
                            guard let self = self else { return }
                            self.expanded = false
                            self.doReloadRows()
                            self.menuSwipeAnimationInProgress = false})
    }

    
    private func hide(){
        UIView.animate(withDuration: 1.0,
                              animations: { [weak self] in
                                   guard let self = self else { return }
                                   self.menuWidthConstraint.constant = self.menuHiddenWidth
                                   self.containerView.layoutIfNeeded()},
                              completion: { [weak self] _ in
                                   guard let self = self else { return }
                                   self.expanded = false
                                   self.doReloadRows()
                                   self.menuSwipeAnimationInProgress = false})
    }
    
    
    
    
    private func doReloadRows(){
        var dd = [IndexPath]()
        let indexPaths = self.idxPaths.compactMap({$0.value})
        for ind in indexPaths {
            for i in ind {
                dd.append(i)
            }
        }
        self.beginUpdates()
        self.reloadRows(at: dd, with: .automatic)
        self.endUpdates()
    }
    
    
    
    
    
    
    
//MARK:- Menu Item: add/remove
    
    private func addMenuSection(indexPath: IndexPath){
        
        removeMenuSection(indexPath: indexPath)
        
        deepIndexSection += 1
        
        let menu = getSubMenu(indexPath)
        
        var indexPaths = [IndexPath]()
        
        guard let _menu = menu else {
            deepIndexSection -= 1
            return
        }
        
        addSelectedMenuItem(indexPath: menu?.indexPath, menu: menu)
        
        //generate new indexes for every menu item in menu
        var count = -1
        for _ in _menu.menuItems {
            count += 1
            let indexPath = IndexPath(row: count, section: deepIndexSection)
            indexPaths.append(indexPath)
            idx2realIdx[indexPath] = menu?.indexPath
            
            if idxPaths[deepIndexSection] == nil {
                idxPaths[deepIndexSection] = []
            }
            idxPaths[deepIndexSection]?.append(indexPath)
            
        }
        if !indexPaths.isEmpty {
            rowsInSection[deepIndexSection] = indexPaths.count
            let indexSet = IndexSet(integer: deepIndexSection)
            beginUpdates()
            insertSections(indexSet, with: .fade)
            insertRows(at: indexPaths, with: .fade)
            endUpdates()
            scrollToRow(at: indexPaths.last!, at: .bottom, animated: true)
        }
    }
    
    
    
    
    private func removeMenuSection(indexPath: IndexPath) {
        guard deepIndexSection > indexPath.section else { return }
        
        while (deepIndexSection > indexPath.section) {
            
            idxPaths[deepIndexSection] = nil
            
            let indexSet = IndexSet(integer: deepIndexSection)
            selected[deepIndexSection] = nil
            rowsInSection[deepIndexSection] = 0
            deepIndexSection -= 1
            beginUpdates()
            deleteSections(indexSet, with: .fade)
            endUpdates()
            reloadData()
        }
    }
    
    
    private func addSelectedMenuItem(indexPath: IndexPath?, menu: Menu?) {
        if let idx = indexPath {
            selected[idx.section] = menu
        }
    }
    
    
    private func getSubMenu(_ indexPath: IndexPath) -> Menu? {
        if let pair = idx2realIdx.first(where: {$0.key == indexPath}) {
            let index = IndexPath(row: pair.key.row, section: deepIndexSection)
            let filter = menues.first(where:{$0.indexPath == index && $0.parentIndexPath == pair.value})
            return filter
        }
        return nil
    }
}

extension MenuTableView: MenuTableViewDelegate {
    func scrollUp() {
        if let indexPaths = idxPaths[0] {
          scrollToRow(at: indexPaths.last!, at: .bottom, animated: true)
        }
    }
}
