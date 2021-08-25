//
//  ViewSetupable.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

/// Interface for setting up the view.
protocol ViewSetupable where Self: CodeView {
    
    /// Add subviews to the view when called.
    func setupViewHierarchy()
    
    /// Add constraints to the view when called.
    func setupConstraints()
    
    /// Setup required properties when called.
    func setupProperties()
}

extension ViewSetupable {
    
    /// Empty default implementation. Not everycalss need this method.
    func setupProperties() {}
    
    /// Calls all other setup methods in proper order.
    func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setupProperties()
    }
}
