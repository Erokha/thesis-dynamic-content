//
//  ViewController.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import UIKit

final class InitialViewController: UIViewController {
    
    private var tdcView: TDCView? {
        didSet {
            tdcView?.layout(on: view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {[weak self] in self?.requestView() }
    }
    
    private func requestView() {
        LayoutRequestService().requestHardcodeLayout { (response) in
            switch response {
            case .success(let data):
                let view = TDCView(from: data)
                self.tdcView = view
            case .failure:
                print("error")
            }
        }
    }

}
