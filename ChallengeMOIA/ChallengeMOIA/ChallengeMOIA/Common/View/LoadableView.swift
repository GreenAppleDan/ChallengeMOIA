//
//  LoadableView.swift
//  ChallengeMOIA
//
//  Created by Denis on 27.03.2022.
//

import UIKit

class LoadableView: UIView {
    
    var loadingViewBackgroundColor: UIColor { .background }
    var activityIndicatorColor: UIColor { .brand }
    
    private var loadingView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    final var isLoading: Bool { loadingView?.isHidden == false }
    
    func startLoading() {
        guard !isLoading else { return }
        
        loadingView?.isHidden = false
        activityIndicator?.startAnimating()
    }
    
    func stopLoading() {
        loadingView?.isHidden = true
        activityIndicator?.stopAnimating()
    }
    
    func addLoadingView() {
        guard loadingView == nil else { return }
        let loadingView = UIView()
        
        loadingView.isHidden = true
        loadingView.backgroundColor = loadingViewBackgroundColor
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = activityIndicatorColor
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor)
        ])
        
        loadingView.pin(to: self)
        
        self.loadingView = loadingView
        self.activityIndicator = activityIndicator
    }
}
