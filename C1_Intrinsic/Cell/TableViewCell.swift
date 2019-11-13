import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuItemSelectedButon: UIButton!
    
    
    var delegate: SideMenuItemDelegateProtocol?
    var menuItem: MenuItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(isFilter: Bool, menuItem: MenuItem) {
        backgroundColor = .clear
        self.menuItem = menuItem
        titleLabel.text = menuItem.title
        menuItemSelectedButon.alpha = isFilter ? 1.0 : 0
        setupImage(select: menuItem.selected)
    }
    
    
    @IBAction func doSelectMenuItem(_ sender: Any) {
        delegate?.didSelectMenuItem(for: self) {[weak self] selected in
            self?.setupImage(select: selected)
        }
    }
    
    public func setupImage(select: Bool){
        print(menuItem.title)
        menuItemSelectedButon.setImage(UIImage(systemName: select ? "square.fill" : "square"), for: .normal)
    }
    
    func changeTextSize(expanded: Bool) {
        titleLabel.font = titleLabel.font.withSize(expanded ? 18: 14)
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        menuItemSelectedButon.setImage(UIImage(systemName: "square"), for: .normal)
    }
}
