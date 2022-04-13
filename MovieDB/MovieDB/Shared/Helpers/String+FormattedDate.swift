//
//  String+toDate.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 13/04/2022.
//

import Foundation

extension String {
    var formatted: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        guard let date = formatter.date(from: self) else {
            return nil
        }
        // Desired date format.
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}
