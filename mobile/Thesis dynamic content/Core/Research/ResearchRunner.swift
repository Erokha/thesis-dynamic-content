import Foundation
import UIKit


class ResearchRunnerViewController: UIViewController {
    
    var strategy: MockViewGeneratorStrategy? = nil
    
    weak var researchViewController: ResearchViewController? = nil
    
    let sizes: [Int] = {
        var array = [Int]()
        for number in stride(from: 0, to: 1000, by: 100) {
            array.append(number)
        }
        for number in stride(from: 1000, to: 5000, by: 250) {
            array.append(number)
        }
        for number in stride(from: 5000, to: 10100, by: 500) {
            array.append(number)
        }
        return array
    }()
    
    private var resultData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        DispatchQueue.main.async { [weak self] in
            self?.performTests()
        }
    }
    
        
    private func performTests() {
        guard let strategy = strategy else {
            return
        }

        for size in sizes {
            let creation = {
                self.createResearchViewController()
                strategy.generateMockData(numberOfViews: size)
            }
            let measuringOperation: () -> Void = {
                self.researchViewController?.layoutData(
                    data: strategy.loadViewWithData()
                )
            }
            let finalizer = {
                self.removeResearchViewController()
            }
            let ellapser = TimeEllapser(
                nonEllapsedPrepareBlock: creation,
                measuringOperation,
                nonEllapsedFinalizerBlock: finalizer
            )
            
            let time = ellapser.calculateTime(avarageOf: 8)
            
            
            let msg = "\(size) - \(time) sec."
            print(msg)
            
        }
    }
    
    private func hardcodeTest() {

        for size in sizes {
            
            let dtoTime = prepareEllapser(size: size, strategy: DTOMockGeneratorStrategy())
                .calculateTime()
            let domainTime = prepareEllapser(size: size, strategy: DomainMockGeneratorStrategy())
                .calculateTime()
            
            
            let msg = "Size: \(size) \(dtoTime - domainTime)sec."
            print(msg)
            
        }
    }
    
    private func prepareEllapser(size: Int, strategy: MockViewGeneratorStrategy) -> TimeEllapser {
        let creation = {
            strategy.generateMockData(numberOfViews: size)
            self.createResearchViewController()
        }
        let measuringOperation: () -> Void = {
            self.researchViewController?.layoutData(
                data: strategy.loadViewWithData()
            )
        }
        let finalizer = {
            self.removeResearchViewController()
        }
        return TimeEllapser(
            nonEllapsedPrepareBlock: creation,
            measuringOperation,
            nonEllapsedFinalizerBlock: finalizer
        )
    }

    private func removeResearchViewController() {
        researchViewController?.willMove(toParent: nil)
        researchViewController?.view.flatMap { $0.removeFromSuperview() }
        researchViewController?.removeFromParent()
        researchViewController = nil
    }

    private func createResearchViewController() {
        let vc = ResearchViewController()
        researchViewController = vc
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: view.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vc.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            vc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
}

extension ResearchRunnerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = resultData[indexPath.row]
        return cell
    }
    
    
}
