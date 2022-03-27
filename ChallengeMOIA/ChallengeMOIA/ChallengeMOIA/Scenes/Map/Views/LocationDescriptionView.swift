//
//  LocationDescriptionView.swift
//  ChallengeMOIA
//
//  Created by Denis on 27.03.2022.
//

import UIKit

final class LocationDescriptionView: LoadableView {
    
    private lazy var closeButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    
    private let onCloseTap: (() -> Void)?
    
    init(onCloseTap: (() -> Void)?) {
        
        self.onCloseTap = onCloseTap
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(titleText: String, subtitleText: String) {
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
    // MARK: Private
    private func setup() {
        configureMainView()
        addCloseButton()
        addTitleLabel()
        addSubtitleLabel()
        addLoadingView()
    }
    
    private func configureMainView() {
        clipsToBounds = true
        backgroundColor = .background
        layer.cornerRadius = 20
    }
    
    private func addCloseButton() {
        // Configuration
        closeButton.setImage(.closeIconNormal, for: .normal)
        closeButton.setImage(.closeIconHighlighted, for: .highlighted)
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        
        // Add as subview
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.topAnchor.constraint(equalTo: topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func addTitleLabel() {
        // Configuration
        titleLabel.textColor = .primaryText
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        
        // Add as subview
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10)
        ])
    }
    
    private func addSubtitleLabel() {
        // Configuration
        subtitleLabel.textColor = .secondaryText
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        // Add as subview
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 44)
        ])
    }
    
    override func addLoadingView() {
        super.addLoadingView()
        bringSubviewToFront(closeButton)
    }
    
    @objc private func closeButtonDidTap() {
        onCloseTap?()
    }
}
