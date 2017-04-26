import UIKit

public extension Animator {
    public class func shake(view: UIView) {
        shake(view: view, times: 8, delta: 15, speed: 0.05)
    }
    
    public class func shake(view: UIView, times: Int, delta: CGFloat, completion: SimpleAction? = nil) {
        shake(view: view, times: times, delta: delta, speed: 0.05, completion: completion)
    }
    
    public class func shake(view: UIView, times: Int, delta: CGFloat, speed: TimeInterval, completion: SimpleAction? = nil) {
        shake(view: view, times: times, delta: delta, speed: speed, shakeDirection: .horizontal, completion: completion)
    }
    
    public class func shake(view: UIView, times: Int, delta: CGFloat, speed: TimeInterval, shakeDirection: ShakeDirection, completion: SimpleAction? = nil) {
        shake(view: view, times: times, direction: 1, currentTimes: 0, delta: delta, speed: speed, shakeDirection: shakeDirection, completion: completion)
    }
    
    private class func shake(view: UIView, times: Int, direction: Int, currentTimes: Int, delta: CGFloat, speed: TimeInterval, shakeDirection: ShakeDirection, completion: SimpleAction? = nil) {
        UIView.animate(withDuration: speed,
                       animations: {
                        switch shakeDirection {
                        case .horizontal:
                            let affineTransform = CGAffineTransform(translationX: delta * direction, y: 0)
                            view.layer.setAffineTransform(affineTransform)
                        case .vertical:
                            let affineTransform = CGAffineTransform(translationX: 0, y: delta * direction)
                            view.layer.setAffineTransform(affineTransform)
                        case .rotation:
                            let affineTransform = CGAffineTransform(rotationAngle: .pi * delta / 1000.0 * direction)
                            view.layer.setAffineTransform(affineTransform)
                        }
                     }, completion: { finished in
                        if currentTimes >= times {
                            UIView.animate(withDuration: speed,
                                           animations: {
                                            view.layer.setAffineTransform(.identity)
                            }, completion: { _ in
                                completion?()
                            })
                            return
                        }
                        self.shake(view: view,
                                   times: (times - 1),
                                   direction: (-direction),
                                   currentTimes: (currentTimes + 1),
                                   delta: delta,
                                   speed: speed,
                                   shakeDirection: shakeDirection,
                                   completion: completion)
        })
    }
}
