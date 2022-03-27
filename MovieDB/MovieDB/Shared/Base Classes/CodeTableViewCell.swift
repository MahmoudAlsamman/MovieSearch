//
//  CodeTableViewCell.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 26/08/2021.
//

import UIKit

class CodeTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        fatalError("override this method to setup the view")
    }
}
