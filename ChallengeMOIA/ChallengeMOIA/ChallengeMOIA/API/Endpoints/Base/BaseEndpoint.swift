//
//  BaseEndpoint.swift
//  ChallengeMOIA
//
//  Created by Denis on 25.03.2022.
//

import Foundation

/// Base Endpoint for application remote resource.
///
/// Contains shared logic for all endpoints in app.
protocol BaseEndpoint: Endpoint where Content: Decodable {
    /// Content wrapper.
    associatedtype Root: Decodable = Content

    /// Extract content from root.
    func content(from root: Root) -> Content
}

extension BaseEndpoint where Root == Content {
    func content(from root: Root) -> Content { return root }
}

extension BaseEndpoint {

    // MARK: - Endpoint

    func content(from response: URLResponse?, with body: Data) throws -> Content {
        let resource = try JSONDecoder.default.decode(Root.self, from: body)
        return content(from: resource)
    }
}
