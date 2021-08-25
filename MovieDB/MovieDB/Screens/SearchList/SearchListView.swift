//
//  SearchListView.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

final class SearchListViewView: CodeView {
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(MovieCellView.self, forCellReuseIdentifier: MovieCellView.id)
        tb.rowHeight = 70
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        return tb
    }()
    
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }
}

extension SearchListViewView: ViewSetupable {
    func setupViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
}
