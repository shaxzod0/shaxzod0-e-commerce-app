//
//  BaseViewController.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 15/02/23.
//

import UIKit
import Reachability
import RxReachability
import RxSwift
import SnapKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    var disposeBag: DisposeBag = .init()
    var loadingView: UIView = .init()
    var loadingLogo: UIImageView = .init()
    let noConnectionView: UIView = .init()
    var loadingText: String?
    var reachability: Reachability?
    
    // MARK: - Fields
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var isLoading: Bool = false {
        didSet {
            view.bringSubviewToFront(loadingView)
            loadingView.isHidden = !isLoading
            if isLoading {
//                loadingLogo.rotate360Degrees()
            } else {
                loadingLogo.layer.removeAllAnimations()
            }
        }
    }
    
    var noConnection: Bool = false {
        didSet {
            noConnectionView.isHidden = !noConnection
        }
    }
    
    var hidesBackButton: Bool = false {
        didSet {
            self.navigationItem.hidesBackButton = hidesBackButton
        }
    }
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension BaseViewController {
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            reachability =  try Reachability()
        } catch {
            
        }
        
        reachability?.rx.isConnected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { () in
                if !self.isLoading && self.noConnection {
                    self.retry()
                }
            })
            .disposed(by: disposeBag)
        view.backgroundColor = .lightGray
        
//        listenForTapsOnViewToDismissKeyboard()

        setupUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? reachability?.startNotifier()
    }

   override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       reachability?.stopNotifier()
    }

   override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension BaseViewController {
    
    // MARK: - Setup

    private func setupUI() {
        var indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = .init(style: .large)
        } else {
            indicator = .init(style: .gray)
        }
        
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(indicator)
        let loadingLabel: UILabel = .init()
        loadingLabel.text = loadingText
//        loadingLabel.font = UIFont.setFont(.kFontRegular, size: 15)
        loadingLabel.textColor = .gray
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(loadingLabel)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        view.addSubview(loadingView)
        
        indicator.topAnchor.constraint(equalTo: loadingView.topAnchor).isActive = true
        indicator.leftAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: loadingView.leftAnchor, multiplier: 1).isActive = true
        indicator.rightAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: loadingView.rightAnchor, multiplier: 1).isActive = true
        indicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 4).isActive = true
        loadingLabel.leftAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: loadingView.leftAnchor, multiplier: 1).isActive = true
        loadingLabel.rightAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: loadingView.rightAnchor, multiplier: 1).isActive = true
        loadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        loadingLabel.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor).isActive = true
        
        
        
        indicator.isHidden = true
        loadingLabel.isHidden = true
        let loadingLogoView = UIView()
        loadingLogoView.backgroundColor = .white
//        loadingLogoView.cornerRadius = 8
        
        loadingView.addSubview(loadingLogoView)
        loadingLogoView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(90)
        }
        
        loadingLogo = UIImageView(image: UIImage(named: "logo"))
        loadingLogoView.addSubview(loadingLogo)
        loadingLogo.snp.makeConstraints { make in
            make.width.height.equalTo(65)
            make.center.equalToSuperview()
        }
   
        loadingView.backgroundColor = .systemRed.withAlphaComponent(0.6)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        
        
        let noConnectionImageView: UIImageView = .init(image: UIImage(named: "icon_no_connection"))
        noConnectionImageView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.addSubview(noConnectionImageView)
        
        let noConnectionLabel: UILabel = .init()
        noConnectionLabel.font = .systemFont(ofSize: 12)
        noConnectionLabel.textColor = .gray
        noConnectionLabel.text = "error_no_internet"
        noConnectionLabel.translatesAutoresizingMaskIntoConstraints = false
        noConnectionLabel.numberOfLines = 0
        noConnectionLabel.textAlignment = .center
        noConnectionView.addSubview(noConnectionLabel)
        
//        let noConnectionButton: UIButton = RectButton(image: nil, title: "str_retry".localized, frame: .zero)
//        noConnectionButton.addTarget(self, action: #selector(self.retry), for: .touchUpInside)
//        noConnectionView.addSubview(noConnectionButton)
        
        noConnectionView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.isHidden = true
        view.addSubview(noConnectionView)
        
        
        noConnectionImageView.centerXAnchor.constraint(equalTo: noConnectionView.centerXAnchor).isActive = true
        noConnectionImageView.topAnchor.constraint(equalTo: noConnectionView.topAnchor).isActive = true
        
        noConnectionLabel.leftAnchor.constraint(equalTo: noConnectionView.leftAnchor).isActive = true
        noConnectionLabel.rightAnchor.constraint(equalTo: noConnectionView.rightAnchor).isActive = true
        noConnectionLabel.topAnchor.constraint(equalTo: noConnectionImageView.bottomAnchor, constant: 4).isActive = true
        
//        noConnectionButton.centerXAnchor.constraint(equalTo: noConnectionView.centerXAnchor).isActive = true
//        noConnectionButton.topAnchor.constraint(equalTo: noConnectionLabel.bottomAnchor, constant: 8).isActive = true
//        noConnectionButton.bottomAnchor.constraint(equalTo: noConnectionView.bottomAnchor).isActive = true
//        
        
        noConnectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noConnectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        noConnectionView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
    }
    
    func initRightBarButtonItem(image: UIImage? = nil, text: String? = nil) {
        
        if let image = image {
            let rightBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonAction))
            rightBarButton.tintColor = .blue
            self.navigationItem.rightBarButtonItem = rightBarButton
        } else if let text = text {
            let rightBarButton = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(rightBarButtonAction))
            rightBarButton.tintColor = .black
            self.navigationItem.rightBarButtonItem = rightBarButton
        }

    }
    
    
}

extension BaseViewController {
    // MARK: - Actions
    
    func listenForTapsOnViewToDismissKeyboard() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func retry() {
        
    }
    
    @objc func rightBarButtonAction() {
        
    }
    
}
