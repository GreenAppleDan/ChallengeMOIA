//
//  Error+Cancelation.swift
//  ChallengeMOIA
//
//  Created by Denis on 29.03.2022.
//

import Foundation

extension Error {
    var isCanceled: Bool {
        (self as NSError).code == -999
    }
}
