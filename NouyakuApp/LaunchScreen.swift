//
//  LaunchScreen.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/22.
//

import Foundation
import UIKit




class LaunchScreenManager {
    
    // MARK: - Properties
    
    // Using a singleton instance and setting animationDurationBase on init makes this class easier to test
    static let instance = LaunchScreenManager(animationDurationBase: 1.2)
    
    var view: UIView?
    var parentView: UIView?
    let animationDurationBase: Double
    
    
    // MARK: - Lifecycle
    
    init(animationDurationBase: Double) {
        self.animationDurationBase = animationDurationBase
    }
    
    // MARK: - Animation
    
    func animateAfterLaunch(_ parentViewPassedIn: UIView) {
        parentView = parentViewPassedIn
        view = loadView()
        fillParentViewWithView()
        hideRingSegments()
    }
    
    func loadView() -> UIView {
        return UINib(nibName: "LaunchScreen", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func fillParentViewWithView() {
        parentView!.addSubview(view!)
        
        view!.frame = parentView!.bounds
        view!.center = parentView!.center
    }
    
    func hideRingSegments() {
        let seg = view!.viewWithTag(1)!
        
        UIView.animate(
            withDuration: animationDurationBase * 1.75,
            delay: animationDurationBase / 1.5,
            options: .curveLinear,
            animations: {
                seg.alpha = 0.0
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 1.0,
                    delay: 0.0,
                    options: .curveLinear,
                    animations: {
                        self.view?.alpha = 0.0
                    }
                ) 
            }
        )
    }
}
