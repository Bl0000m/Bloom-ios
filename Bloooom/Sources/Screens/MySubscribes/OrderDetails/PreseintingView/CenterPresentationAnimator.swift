import UIKit

class CenterPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4 // Длительность анимации
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        if isPresenting {
            containerView.addSubview(toView)
            toView.center = containerView.center
            toView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            toView.alpha = 0.0
            
            UIView.animate(withDuration: duration, animations: {
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1.0
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        } else {
            UIView.animate(withDuration: duration, animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                fromView.alpha = 0.0
            }, completion: { finished in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(finished)
            })
        }
    }
}
