//
//  CodeTableViewCell.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 26/08/2021.
//

import UIKit

class CodeTableViewCell: UITableViewCell {
    
    private var isLayedout: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard !isLayedout else { return }
        setupLayout()
        isLayedout = true
    }
    
    func setupLayout() {
        fatalError("override this method to setup the view")
    }
}
