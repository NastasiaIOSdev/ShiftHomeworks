//
//  WeatherDiaryViewDataSourse.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import UIKit

class WeatherDiaryViewDataSourse: NSObject {
    var data = [WeatherDiaryEntity]()
}

extension WeatherDiaryViewDataSourse: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: WeatherNoteCell.id, for: indexPath) as? WeatherNoteCell else { return UITableViewCell()}
        cell.displayData(data[indexPath.row])
        return cell
    }
    
    
}
