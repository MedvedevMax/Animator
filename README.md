# Animator
`Animator` is flexible UIView animation builder with beautiful chaining syntax. It supports classic animations as well as awesome spring animations.

## Demo
![Animator](readme-assets/animator-demo.gif)

It's that simple to achieve this:

```swift
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tryItButton: UIButton!
    @IBOutlet weak var snackBarView: UIView!
    
    private var shakeTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.isHidden = true
        tryItButton.isHidden = true
        snackBarView.isHidden = true
        
        animateInitialAppearance()
        startTimerForShake()
    }
    
    @IBAction func didTapTryIt() {
        animateSnackbarAppearing()
    }
    
    // MARK: - Animations
    
    private func animateInitialAppearance() {
        Animator.fadeIn(view: titleLabel)
            .with(duration: 2.0)
            .with(delay: 0.3)
            .then {
                Animator.fadeIn(view: self.tryItButton)
                    .with(duration: 2.0)
                    .start()
            }
            .start()
    }
    
    private func startTimerForShake() {
        shakeTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
            Animator.shake(view: self.tryItButton).start()
        }
    }
    
    private func animateSnackbarAppearing() {
        guard snackBarView.isHidden else {
            return
        }
        
        Animator()
            .firstlySetAlpha(forView: snackBarView, to: 0.0)
            .firstlyShow(view: snackBarView)
            .firstlySetOffset(forView: snackBarView, x: 0.0, y: 10.0)
            .animateAlpha(forView: snackBarView, to: 1.0)
            .animateOffset(forView: snackBarView, x: 0.0, y: 0.0)
            .with(initialVelocity: 0.5)
            .with(duration: 0.3)
            .then {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: self.animateSnackbarDisappearing)
            }
            .start()
    }
    
    private func animateSnackbarDisappearing() {
        guard !snackBarView.isHidden else {
            return
        }
        
        Animator()
            .animateAlpha(forView: snackBarView, to: 0.0)
            .animateOffset(forView: snackBarView, x: 0.0, y: 10.0)
            .thenHide(view: snackBarView)
            .with(initialVelocity: 0.5)
            .with(duration: 0.3)
            .start()
    }
}
```