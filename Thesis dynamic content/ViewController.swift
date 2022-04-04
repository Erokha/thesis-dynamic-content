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
        
        
        let tdcView = makeUIView()
        view.addSubview(tdcView.UIView)
        NSLayoutConstraint.activate([
//            uiview.heightAnchor.constraint(equalToConstant: 50),
//            uiview.widthAnchor.constraint(equalToConstant: 50),
            tdcView.UIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tdcView.UIView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        tdcView.applyConstraints()
        
    }
    
    private func makeUIView() -> TDCView {
        let configurationDTO = TDCViewConfigurationDTO(
            color: "#FFFF66",
            cornerRadius: 5
        )
        let viewDTO = TDCViewDTO(id: "id", configuration: configurationDTO, subviews: [])
        
        let view = TDCView(from: viewDTO)
        view.constraints = [
            TDCSizeConstaint(type: .width, value: .absoulte(120)),
            TDCSizeConstaint(type: .height, value: .absoulte(120))
        ]
        return view
    }


}

