//
//  WeatherDiaryViewController.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit
import SnapKit

final class WeatherDiaryViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Properties
    
   
    private enum Constraints {
        static let tableViewHorizontalOffset = 17
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
    }
}

    // MARK - Navigation

private extension WeatherDiaryViewController {
    func routeToNewNote() {
        let nextVC = WeatherNoteViewControllerAssembly.build()
        self.navigationController?.pushViewController(nextVC, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    }
    func routeToEditNote(forIndexPath: Int) {
        let vc = WeatherNoteViewController()
        self.present(vc, animated: true)
    }
}


private extension WeatherDiaryViewController {
    
    
    
    func setupNavBar() {
        let image = UIImage(named: "edit")
        let uiBArButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.onNewNoteButtonPressed))
        uiBArButtonItem.tintColor = .white
        self.navigationItem.setRightBarButton(uiBArButtonItem, animated: true)
    }
    
    
    @objc
    func onNewNoteButtonPressed() {
        self.routeToNewNote()
    }
}
