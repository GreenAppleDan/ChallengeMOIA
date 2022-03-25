//
//  Decoder.swift
//  ChallengeMOIA
//
//  Created by Denis on 25.03.2022.
//

import Foundation

extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
