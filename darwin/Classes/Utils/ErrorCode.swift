//
//  ErrorCode.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 11/12/2020.
//

import Foundation

public enum ErrorCode: String {
    case platformError = "Error"
    case wrongArguments = "WrongArguments"
    case updateManagerExists = "UpdateManagerExists"
    case updateManagerDoesNotExist = "UpdateManagerDoesNotExist"
    case flutterTypeError = "FlutterTypeError"
    case updateError = "UpdateError"
}
