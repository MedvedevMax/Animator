import UIKit

final public class Animator {
    public typealias SimpleAction = (() -> Void)
    
    public init() { }
    
    // MARK: - Properties
    private var initialActions: [SimpleAction] = []
    private var animationActions: [SimpleAction] = []
    private var completionActions: [SimpleAction] = []
    
    private var options: UIViewAnimationOptions = []
    private var duration: TimeInterval = 0.3
    private var delay: TimeInterval = 0.0
    
    private var isSpingAnimation = false
    private var springDamping: CGFloat = 1.0 {
        didSet {
            updateIsSpring()
        }
    }
    
    private var initialVelocity: CGFloat = 0.0 {
        didSet {
            updateIsSpring()
        }
    }
    
    // MARK: - Firstly
    public func firstly(action: @escaping SimpleAction) -> Self {
        initialActions.append(action)
        return self
    }
    
    public func firstlyShow(view: UIView) -> Self {
        initialActions.append({
            view.isHidden = false
        })
        return self
    }
    
    public func firstlyHide(view: UIView) -> Self {
        initialActions.append({
            view.isHidden = true
        })
        return self
    }
    
    public func firstlySetAlpha(forView view: UIView, to value: CGFloat) -> Self {
        initialActions.append({
            view.alpha = value
        })
        return self
    }
    
    public func firstlySetBackgroundColor(forView view: UIView, to value: UIColor) -> Self {
        initialActions.append({
            view.backgroundColor = value
        })
        return self
    }
    
    public func firstlySetTextColor(forLabel label: UILabel, to value: UIColor) -> Self {
        initialActions.append({
            label.textColor = value
        })
        return self
    }
    
    public func firstlySetScale(forView view: UIView, to value: CGFloat) -> Self {
        initialActions.append({
            view.transform = CGAffineTransform(scaleX: value, y: value)
        })
        return self
    }
    
    public func firstlySetOffset(forView view: UIView, x: CGFloat, y: CGFloat) -> Self {
        initialActions.append({
            view.transform = CGAffineTransform(translationX: x, y: y)
        })
        return self
    }
    
    // MARK: - Animate
    
    public func animate(action: @escaping SimpleAction) -> Self {
        animationActions.append(action)
        return self
    }
    
    public func animateLayout(forView view: UIView) -> Self {
        animationActions.append({
            view.layoutIfNeeded()
        })
        return self
    }
    
    public func animateAlpha(forView view: UIView, to value: CGFloat) -> Self {
        animationActions.append({
            view.alpha = value
        })
        return self
    }
    
    public func animateBackgroundColor(forView view: UIView, to value: UIColor) -> Self {
        animationActions.append({
            view.backgroundColor = value
        })
        return self
    }
    
    public func animateTextColor(forLabel label: UILabel, to value: UIColor) -> Self {
        animationActions.append({
            label.textColor = value
        })
        return self
    }
    
    public func animateScale(forView view: UIView, to value: CGFloat) -> Self {
        animationActions.append({
            view.transform = CGAffineTransform(scaleX: value, y: value)
        })
        return self
    }
    
    public func animateOffset(forView view: UIView, x: CGFloat, y: CGFloat) -> Self {
        animationActions.append({
            view.transform = CGAffineTransform(translationX: x, y: y)
        })
        return self
    }
    
    // MARK: - Then
    
    public func then(action: @escaping SimpleAction) -> Self {
        completionActions.append(action)
        return self
    }
    
    public func thenHide(view: UIView) -> Self {
        completionActions.append({
            view.isHidden = true
        })
        return self
    }
    
    public func thenShow(view: UIView) -> Self {
        completionActions.append({
            view.isHidden = false
        })
        return self
    }
    
    public func thenSetAlpha(forView view: UIView, to value: CGFloat) -> Self {
        completionActions.append({
            view.alpha = value
        })
        return self
    }
    
    // MARK: - Settings
    
    public func with(options: UIViewAnimationOptions) -> Self {
        self.options = options
        return self
    }
    
    public func with(duration: TimeInterval) -> Self {
        self.duration = duration
        return self
    }
    
    public func with(delay: TimeInterval) -> Self {
        self.delay = delay
        return self
    }
    
    public func with(springDamping: CGFloat) -> Self {
        self.springDamping = springDamping
        return self
    }
    
    public func with(initialVelocity: CGFloat) -> Self {
        self.initialVelocity = initialVelocity
        return self
    }
    
    // MARK: - Start
    
    public func start() {
        run(actions: initialActions)
        
        if isSpingAnimation {
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: springDamping, initialSpringVelocity: initialVelocity, options: options, animations: { 
                self.run(actions: self.animationActions)
            }, completion: { _ in
                self.run(actions: self.completionActions)
            })
        }
        else {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                self.run(actions: self.animationActions)
            }, completion: { _ in
                self.run(actions: self.completionActions)
            })
        }
    }
    
    // MARK: - Private
    
    private func run(actions: [SimpleAction]) {
        for action in actions {
            action()
        }
    }
    
    private func updateIsSpring() {
        isSpingAnimation = springDamping < 1.0 || initialVelocity > 0.0
    }
}
