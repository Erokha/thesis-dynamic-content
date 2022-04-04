//
//  ViewController.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import UIKit

final class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        let uiview = makeUIView()
        view.addSubview(uiview)
        NSLayoutConstraint.activate([
            uiview.heightAnchor.constraint(equalToConstant: 50),
            uiview.widthAnchor.constraint(equalToConstant: 50),
            uiview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    private func makeUIView() -> UIView {
        let configurationDTO = TDCViewConfigurationDTO(
            color: "#FFFF66",
            cornerRadius: 5
        )
        let viewDTO = TDCViewDTO(configuration: configurationDTO)
        
        let view = TDCView(from: viewDTO)
        return view.UIView
    }


}

