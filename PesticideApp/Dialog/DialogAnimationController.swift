//
//  DialogAnimationController.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/22.
//

import Foundation
import UIKit


class DialogAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let forPresented: Bool
    
    init(forPresented: Bool) {
        self.forPresented = forPresented
    }
    
    // アニメーション時間
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if (forPresented) {
            presentAnimateTransition(transitionContext: transitionContext)
        } else {
            dismissAnimateTransition(transitionContext: transitionContext)
        }
    }
    
    // 表示時に使用するアニメーション
    func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let viewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        containerView.addSubview(viewController.view)
        viewController.view.alpha = 0.0
        viewController.view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
            viewController.view.alpha = 1.0
            viewController.view.transform = CGAffineTransform.identity
        },
                       completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
    
    // 非表示時に使用するアニメーション
    func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let viewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
            viewController.view.alpha = 0.0
        },
                       completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}
