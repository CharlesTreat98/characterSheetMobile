//
//  CustomCharacterCellTableViewCell.swift
//  CharSheet
//
//  Created by Charlie Treat on 6/18/21.
//

import UIKit

final class CustomCharacterCellTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
