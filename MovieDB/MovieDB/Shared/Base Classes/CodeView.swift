//
//  CodeView.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

/// Base class for UIView to subclasses to remove boilerplate from views.
class CodeView: UIView {
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let setupableView = self as? ViewSetupable else { return }
        setupableView.setupView()
    }
   
    @available(*, unavailable) required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
