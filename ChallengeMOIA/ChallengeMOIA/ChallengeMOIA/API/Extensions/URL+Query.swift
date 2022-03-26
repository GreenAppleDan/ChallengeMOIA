//
//  URL+Query.swift
//  ChallengeMOIA
//
//  Created by Denis on 26.03.2022.
//

import Foundation

extension URL {

    func appendingQueryItems(_ items: [URLQueryItem]) throws -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL, userInfo: [NSURLErrorKey: self])
        }

        var queryItems = components.queryItems ?? []
        queryItems.append(contentsOf: items)
        components.queryItems = queryItems

        guard let url = components.url else {
            throw URLError(.badURL, userInfo: [NSURLErrorKey: self])
        }
        return url
    }

}
