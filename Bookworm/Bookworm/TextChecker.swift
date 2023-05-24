//
//  TextChecker.swift
//  Bookworm
//
//  Created by Berardino Chiarello on 23/05/23.
//

import Foundation

extension String {
    var isValid : Bool{
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
