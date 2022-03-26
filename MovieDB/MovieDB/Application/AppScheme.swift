//
//  AppScheme.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 26/08/2021.
//

import Foundation

enum AppScheme {
    case debug, release
    
    static var current: AppScheme {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
}

extension AppScheme {
    static var logsEnabled: Bool {
        current == .debug
    }
}
