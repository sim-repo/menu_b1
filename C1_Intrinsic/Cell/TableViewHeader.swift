//
//  TableViewHeader.swift
//  C1_Intrinsic
//
//  Created by Igor Ivanov on 13.11.2019.
//  Copyright © 2019 Igor Ivanov. All rights reserved.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!

    var delegate: MenuTableViewDelegate!
    
    @IBOutlet weak var upButton: UIButton!
    
    @IBAction func doUpAction(_ sender: Any) {
        delegate.scrollUp()
    }
    
}
