//
//  ViewController.swift
//  test
//
//  Created by Максим Половинкин on 02.02.2023.
//
import UIKit

//MARK: - States of popView
private enum State {
    case start
    case medium
    case full
    
}

extension State {
    var opposite: State {
        switch self {
        case .start:
            return .medium
        case .medium:
            return .full
        case .full:
            return .full
        }
    }
    
    var previous: State {
        switch self {
        case .start:
            return .start
        case .medium:
            return .start
        case .full:
            return .medium
        }
    }
}
//MARK: - Main VC
class ViewController: UIViewController {
    
    private var constraint:CGFloat = 420
    private var currentState: State = .start
    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var indentOfView: CGFloat = 440
    private let coursesMenu = OneLineCollectionView()
    private let twoLinesMenu = TwoLinesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
    }
    
    //MARK: - UI Elements
    
    private let backImage: UIImageView = {
        let img = UIImageView()
        
        img.image = UIImage(named: "Image")
        
        return img
    }()
    
    private let requestButton: UIButton = {
        let btn = UIButton()
        
        btn.backgroundColor = #colorLiteral(red: 0.1921568811, green: 0.1921568811, blue: 0.1921568811, alpha: 1)
        btn.frame = CGRect(x: 100, y: 100, width: 219, height: 60)
        btn.layer.cornerRadius = btn.bounds.height / 2
        btn.setTitle("Отправить заявку", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.text = "Отправить заявку"
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.addTarget(self, action: #selector(openModal), for: .touchUpInside)
        
        return btn
    }()
    
    private let wantAsLabel: UILabel = {
        let label = UILabel()
        
        label.frame = CGRect(x: 20, y: 100, width: 120, height: 20)
        label.text = "Хочешь к нам?"
        label.font = .init(name: "14_20_Regular SF", size: 14)
        label.textColor = #colorLiteral(red: 0.5891124606, green: 0.5841485262, blue: 0.6100190282, alpha: 1)
        
        return label
    }()
    
    private lazy var popupView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        
        label.frame = CGRect(x: 20, y: 100, width: 214, height: 32)
        label.text = "Стажировка в Surf"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = #colorLiteral(red: 0.1921568811, green: 0.1921568811, blue: 0.1921568811, alpha: 1)
        
        return label
    }()

    private var desctiprionTextView: UITextView = { 
        let desctiprionTextView = UITextView()
        
        desctiprionTextView.frame = CGRect(x: 20, y: 100, width: 335, height: 70)
        desctiprionTextView.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        desctiprionTextView.textColor = #colorLiteral(red: 0.5891124606, green: 0.5841485262, blue: 0.6100190282, alpha: 1)
        desctiprionTextView.font = .systemFont(ofSize: 14, weight: .regular)
        desctiprionTextView.isSelectable = false
        desctiprionTextView.isEditable = false
        desctiprionTextView.isScrollEnabled = false
        
        return desctiprionTextView
    }()
    
    private var secondDesctiprionTextView: UITextView = {
        let secondDesctiprionTextView = UITextView()
        
        secondDesctiprionTextView.frame = CGRect(x: 20, y: 100, width: 335, height: 50)
        secondDesctiprionTextView.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."
        secondDesctiprionTextView.textColor = #colorLiteral(red: 0.5891124606, green: 0.5841485262, blue: 0.6100190282, alpha: 1)
        secondDesctiprionTextView.font = .systemFont(ofSize: 14, weight: .regular)
        secondDesctiprionTextView.isSelectable = false
        secondDesctiprionTextView.isEditable = false
        secondDesctiprionTextView.isScrollEnabled = false
        secondDesctiprionTextView.alpha = 0.0
        secondDesctiprionTextView.backgroundColor = .none
        
        return secondDesctiprionTextView
    }()
    
    //MARK: - Helpers
    
    /// setup all views
    private func setUpViews() {
        backImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(backImage)
        view.addSubview(popupView)
        
        popupView.addSubview(requestButton)
        popupView.addSubview(wantAsLabel)
        popupView.addSubview(titleLabel)
        popupView.addSubview(desctiprionTextView)
        popupView.addSubview(coursesMenu)
        popupView.addSubview(twoLinesMenu)
        popupView.addSubview(secondDesctiprionTextView)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.isDragging(_:)))
        popupView.addGestureRecognizer(panRecognizer)
        
        setConstraints()
    }
    
    /// Open modal view with congrats
    @objc func openModal(){
        let alert = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Constraints
    
    private var bottomConstraint = NSLayoutConstraint()
    private var topConstraint = NSLayoutConstraint()
    
    private func setConstraints() {
        popupView.translatesAutoresizingMaskIntoConstraints = false
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        backImage.translatesAutoresizingMaskIntoConstraints = false
        wantAsLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        desctiprionTextView.translatesAutoresizingMaskIntoConstraints = false
        secondDesctiprionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 436)
        
        
        NSLayoutConstraint.activate([
            //Background
            backImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -194),
            backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            
            //Reques Button
            requestButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            requestButton.leftAnchor.constraint(equalTo: wantAsLabel.rightAnchor, constant: 20),
            requestButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            requestButton.heightAnchor.constraint(equalToConstant: 60),
            
            //wantAs Label
            wantAsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            wantAsLabel.widthAnchor.constraint(equalToConstant: 120),
            wantAsLabel.heightAnchor.constraint(equalToConstant: 20),
            wantAsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            
            //Title
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 260),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 24),
            
            //First Description
            desctiprionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17),
            desctiprionTextView.widthAnchor.constraint(equalToConstant: 335),
            desctiprionTextView.heightAnchor.constraint(equalToConstant: 70),
            
            //PopView
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomConstraint,
            popupView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -44),
          
            
            //First CollectionView
            coursesMenu.topAnchor.constraint(equalTo: desctiprionTextView.bottomAnchor, constant: 12),
            coursesMenu.leftAnchor.constraint(equalTo: popupView.leftAnchor, constant: 20),
            coursesMenu.heightAnchor.constraint(equalToConstant: 44),
            coursesMenu.rightAnchor.constraint(equalTo: popupView.rightAnchor, constant: -20),
            coursesMenu.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 140),
            
            //Second Description
            secondDesctiprionTextView.leftAnchor.constraint(equalTo: popupView.leftAnchor, constant: 20),
            secondDesctiprionTextView.heightAnchor.constraint(equalToConstant: 50),
            secondDesctiprionTextView.widthAnchor.constraint(equalToConstant: 335),
            secondDesctiprionTextView.topAnchor.constraint(equalTo: coursesMenu.bottomAnchor, constant: 24),
            
            //Second CollectionView
            twoLinesMenu.topAnchor.constraint(equalTo: secondDesctiprionTextView.bottomAnchor, constant: 12),
            twoLinesMenu.leftAnchor.constraint(equalTo: popupView.leftAnchor, constant: 20),
            twoLinesMenu.heightAnchor.constraint(equalToConstant: 100),
            twoLinesMenu.rightAnchor.constraint(equalTo: popupView.rightAnchor, constant: -75)
        ])
        
    }
    
    
    //MARK: - Animation
    
    /// handles drag and drop
    /// - Parameter panRecognizer:UIPanGestureRecognizer
    @objc private func isDragging(_ panRecognizer: UIPanGestureRecognizer) {
        let translation = panRecognizer.translation(in: self.view)
        constraint =  translation.x
        switch panRecognizer.state {
        case .began:
            let currentTranslation = translation
            if currentTranslation.y >= 0 {
                animate(to: currentState.previous, duration: 0.4, translation: currentTranslation.y)
            } else {
                animate(to: currentState.opposite, duration: 0.4, translation: currentTranslation.y)
            }
            
        case .changed:
            let translation = panRecognizer.translation(in: popupView)
            let fraction = abs(translation.y / indentOfView)
            
            runningAnimations.forEach { (animator) in
                animator.fractionComplete = fraction
            }
        case .ended:
            runningAnimations.forEach{$0.continueAnimation(withTimingParameters: nil, durationFactor: 0)}
        default:
            break
        }
    }
    
    private func animate(to state: State, duration: TimeInterval, translation: CGFloat) {
        guard runningAnimations.isEmpty else { return }
        
        let baseAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: nil)
        
        baseAnimator.addAnimations { [unowned self] in
            switch state {
            case .start:
                self.bottomConstraint.constant = 436
                secondDesctiprionTextView.fadeOut()
                twoLinesMenu.fadeOut()
            case .full:
                self.bottomConstraint.constant = 0
                secondDesctiprionTextView.fadeIn()
                twoLinesMenu.fadeIn()
            case .medium:
                self.bottomConstraint.constant = 258
                secondDesctiprionTextView.fadeIn()
                twoLinesMenu.fadeIn()
            }
            self.view.layoutIfNeeded()
        }
        
        baseAnimator.addCompletion { [self] (animator) in
            runningAnimations.removeAll()
            currentState = translation >= 0 ? currentState.previous : currentState.opposite
        }
        runningAnimations.append(baseAnimator)
    }
}

extension UIView {
    //Methods that handle the appearance and disappearance of elements
    func fadeIn(_ duration: TimeInterval = 0.4, delay: TimeInterval = 0.4, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 0.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
