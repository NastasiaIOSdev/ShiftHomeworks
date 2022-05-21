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
    
    private let tableView = UITableView()
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
        self.setupUI()
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
    
    func setupUI() {
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.setupNavBar()
        self.configureTable()
        self.setupTableViewLayout()
    }
    
    func setupNavBar() {
        let image = UIImage(named: "edit")
        let uiBArButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.onNewNoteButtonPressed))
        uiBArButtonItem.tintColor = .white
        self.navigationItem.setRightBarButton(uiBArButtonItem, animated: true)
    }
    
    func configureTable() {
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(WeatherNoteCell.self, forCellReuseIdentifier: WeatherNoteCell.id)
    }
    
    
    func setupTableViewLayout() {
        self.view.addSubview(tableView)
        self.view.backgroundColor = .clear
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    @objc
    func onNewNoteButtonPressed() {
        self.routeToNewNote()
    }
}

    // MARK: - UITableView Delegate & DataSourse

extension WeatherDiaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: WeatherNoteCell.id, for: indexPath) as? WeatherNoteCell else { return UITableViewCell()}
        cell.displayData(WeatherDiaryViewModel())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.routeToEditNote(forIndexPath: indexPath.row)
    }
}
