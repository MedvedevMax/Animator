import UIKit

public extension Animator {
    public class func fadeIn(view: UIView) -> Animator {
        return Animator()
            .firstlySetAlpha(forView: view, to: 0.0)
            .firstlyShow(view: view)
            .animateAlpha(forView: view, to: 1.0)
    }
    
    public class func fadeOut(view: UIView) -> Animator {
        return Animator()
            .animateAlpha(forView: view, to: 0.0)
            .thenHide(view: view)
    }
    
    public class func shake(view: UIView) -> Animator {
        return Animator()
            .firstlySetOffset(forView: view, x: 10.0, y: 0.0)
            .animateOffset(forView: view, x: 0.0, y: 0.0)
            .with(duration: 0.4)
            .with(springDamping: 0.2)
            .with(initialVelocity: 1.0)
    }
}
