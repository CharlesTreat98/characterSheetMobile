import UIKit

final class CustomCharacterCellTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCharacterCellTableViewCell {

    func render(with sheet: CharacterSheet) {

        self.textLabel?.text = sheet.name
        self.textLabel?.font = UIFont(name: "Headline", size: 20.0)
        self.detailTextLabel?.text = "Level: " + String(sheet.level)

        self.detailTextLabel?.textAlignment = .right
    }
}
