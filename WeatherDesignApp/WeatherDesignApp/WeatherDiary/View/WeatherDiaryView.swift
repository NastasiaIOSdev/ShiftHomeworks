//
//  WeatherDiaryView.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation
import UIKit
import SnapKit

protocol IWeatherDiaryView: AnyObject {
    func getData(data: [WeatherDiaryEntity])
}

final class WeatherDiaryView: UIView {
    let delegate = WeatherDiaryViewDelegate()
    private let dataSource = WeatherDiaryViewDataSourse()
    private let tableView = UITableView()
    public var data: [WeatherDiaryEntity]?
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherDiaryView {
    func setupUI() {
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        self.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.configureTable()
        self.setupTableViewLayout()
    }
    
    func configureTable() {
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
        self.tableView.register(WeatherNoteCell.self, forCellReuseIdentifier: WeatherNoteCell.id)
    }
    
    
    func setupTableViewLayout() {
        self.addSubview(tableView)
        self.backgroundColor = .clear
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension WeatherDiaryView: IWeatherDiaryView {
    func getData(data: [WeatherDiaryEntity]) {
        self.dataSource.data = data
        self.tableView.reloadData()
    }
}
