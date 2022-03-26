//
//  URLRequest+HTTP.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

extension URLRequest {

    static func get(_ url: URL) -> URLRequest {
        return URLRequest(url: url)
    }
}
