//  
//  WelcomeController.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import UIKit
import RxSwift

protocol WelcomeDelegate {
    
}

class WelcomeController: BaseViewController {
    
    // MARK: - Properties
    
    // MARK: - Fields
    let viewModel: WelcomeViewModel
    var delegate: WelcomeDelegate
    
    // MARK: - Initializers
    init(viewModel: WelcomeViewModel, delegate: WelcomeDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        super.init()
    }
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        
    }
}

// MARK: - View lifecycle
extension WelcomeController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
        createObservables()
        
    }
}


// MARK: - User Interface
extension WelcomeController {
    private func setupUI() {
        
    }
    
    private func createObservables() {
        
    }
}


// MARK: - Actions
extension WelcomeController {
    
}
