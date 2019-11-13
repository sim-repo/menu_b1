import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(text: String) {
        backgroundColor = .clear
        titleLabel.text = text
    }
    
    func changeTextSize(expanded: Bool) {
        titleLabel.font = titleLabel.font.withSize(expanded ? 18: 14)
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
    }
}
