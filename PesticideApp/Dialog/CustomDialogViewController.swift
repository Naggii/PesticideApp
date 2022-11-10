//
//  CustomDialogViewController.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/22.
//

//
import UIKit


protocol DialogVCDelegate {
    func setImageView(image: UIImage, indexPath: IndexPath)
}

class CustomDialogViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var btnImageSelecgt: UIButton!
    @IBOutlet weak var xImg: UIButton!
    @IBOutlet weak var checkImg: UIButton!
        
    var indexPath: IndexPath?
    var delegate: DialogVCDelegate?
    private var selectedUiImage: UIImage? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xImg.tintColor = .systemRed
        view.backgroundColor = .clear
        checkImg.isHidden = true
    }
    @IBOutlet weak var debugView: UIImageView!
    
    @IBAction func touchBtnImageSelect(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
    
    @IBAction func okButtonDidTap(_ sender: Any) {
        guard let uiImage = selectedUiImage else { return dismiss(animated: true)}
        delegate?.setImageView(image: uiImage, indexPath: indexPath!)
        dismiss(animated: true)
    }
    
    @IBAction func transparentButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DialogPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DialogAnimationController(forPresented: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DialogAnimationController(forPresented: false)
    }
}

extension CustomDialogViewController: UIImagePickerControllerDelegate {
    // カメラロール表示
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let widthSize = debugView.frame.width // 画面の横の大きさを取得
            let heightSize = debugView.frame.height // 画面の縦の大きさを取得
            let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: widthSize, height: heightSize)) // 背景画像の大きさを設定
            imageViewBackground.image = (info[.originalImage] as! UIImage) // カメラロールから受け取った画像を設定

            self.selectedUiImage = (info[.originalImage] as! UIImage)
            self.debugView.addSubview(imageViewBackground) // 背景画像を追加する
            self.checkImg.isHidden = false
            picker.dismiss(animated: true)
        }
}

class DialogPresentationController: UIPresentationController {
    
    /// 呼び出し元のViewControllerの上に重ねるオーバーレイ
    private let overlayView = UIView()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        // 表示トランジション開始前の処理
        overlayView.frame = containerView!.bounds
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.0
        containerView!.insertSubview(overlayView, at: 0)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.overlayView.alpha = 0.5
        })
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // 非表示トランジション開始前の処理
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.overlayView.alpha = 0.0
        })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        // 非表示トランジション終了時の処理
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView : CGRect {
        return containerView!.bounds
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        /// レイアウト開始前の処理
        overlayView.frame = containerView!.bounds
        presentedView!.frame = frameOfPresentedViewInContainerView
    }
}

class DialogAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    
    let forPresented: Bool
    
    init(forPresented: Bool) {
        self.forPresented = forPresented
    }
    
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
