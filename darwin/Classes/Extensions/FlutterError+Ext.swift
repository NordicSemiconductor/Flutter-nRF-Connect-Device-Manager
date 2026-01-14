//
//  FlutterError+Ext.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 11/12/2020.
//

import Foundation

extension FlutterError: Error {
    convenience init(error: Error, code: ErrorCode = .platformError, call: FlutterMethodCall? = nil) {
        self.init(code: code.rawValue, message: error.localizedDescription, details: call)
    }
}
