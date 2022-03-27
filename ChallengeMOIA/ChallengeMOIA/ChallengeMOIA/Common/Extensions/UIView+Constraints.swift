//
//  UIView+Constraints.swift
//  ChallengeMOIA
//
//  Created by Denis on 27.03.2022.
//

import UIKit

extension UIView {
    /// Add one view into another without spacing
    func pin(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
