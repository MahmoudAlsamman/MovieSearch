//
//  CodeViewController.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

class CodeViewController<View: UIView>: UIViewController {
    
    // MARK: - Properties
    let customView: View
    
    // MARK: - LifeCycle
    /// Initializes view controller with given view.
    init(customView: View = View()) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
}
