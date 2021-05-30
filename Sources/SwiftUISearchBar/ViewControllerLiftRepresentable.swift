//
//  ViewControllerLifeRepresentable.swift
//  
//
//  Created by HonQi on 2021/5/30.
//

import SwiftUI

final class ViewControllerLifeRepresentable: UIViewControllerRepresentable {
    typealias ViewControllerMoveCallback = (UIViewController?) -> Void

    let didMoveToParent: ViewControllerMoveCallback?
    let willMoveToParent: ViewControllerMoveCallback?
        
    init(didMoveToParent: ViewControllerMoveCallback? = nil, willMoveToParent: ViewControllerMoveCallback? = nil) {
        self.didMoveToParent = didMoveToParent
        self.willMoveToParent = willMoveToParent
    }
    
    func makeUIViewController(context: Context) -> CallbackViewController {
        CallbackViewController(didMoveToParent: didMoveToParent, willMoveToParent: willMoveToParent)
    }
    
    func updateUIViewController(_ uiViewController: CallbackViewController, context: Context) { }
}

extension ViewControllerLifeRepresentable {
    class CallbackViewController: UIViewController {
        
        var didMoveToParent: ViewControllerMoveCallback?
        var willMoveToParent: ViewControllerMoveCallback?
        
        init(didMoveToParent: ViewControllerMoveCallback? = nil, willMoveToParent: ViewControllerMoveCallback? = nil) {
            super.init(nibName: nil, bundle: nil)
            self.didMoveToParent = didMoveToParent
            self.willMoveToParent = willMoveToParent
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            didMoveToParent?(parent)
        }
        
        override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            willMoveToParent?(parent)
        }
    }
}
