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
        tdcView.applyConstraints()
        
        DispatchQueue.global().async { [weak self] in
            self?.test()
        }
        
    }
    
    private func makeUIView() -> TDCView {
        let configurationDTO = TDCViewConfigurationDTO(
            color: "#FFFF66",
            cornerRadius: 5
        )
        let viewDTO = TDCViewDTO(id: "id", configuration: configurationDTO, subviews: [])
        
        let view = TDCView(from: viewDTO)
        view.constraints = [
            TDCSizeConstaint(
                type: .width,
                value: .absoulte(120)
            ),
            TDCSizeConstaint(
                type: .height,
                value: .absoulte(120)
            ),
            TDCSideConstaint(
                side: .ledftSide,
                value: .relative(
                    TDCSideConstaint.RelativeConstaintData(
                        id: nil,
                        side: .ledftSide,
                        constant: 50
                    )
                )
            ),
            TDCEdgeConstaint(
                edge: .topEdge,
                value: .relative(
                    TDCEdgeConstaint.RelativeConstaintData(
                        id: nil,
                        edge: .topEdge,
                        constant: 50
                    )
                )
            ),
        ]
        return view
    }
    
    private func test() {
        LayoutRequestService().requestHardcodeLayout() { (response) in
            switch response {
            case .success(let data):
                print(data)
            case .failure:
                print("error")
            }
        }
    }


}

