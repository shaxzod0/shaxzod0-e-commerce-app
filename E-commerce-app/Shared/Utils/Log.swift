//
//  Log.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import Foundation
import os.log

final class Log {
    static func error(_ message: String) {
        os_log("%@", log: .default, type: .error, message)
    }

    static func debug(_ message: String) {
        os_log("%@", log: .default, type: .debug, message)
    }
}
