//
//  WeatherDiaryViewDelegate.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation
import UIKit

final class WeatherDiaryViewDelegate: NSObject {
   var delegate: ((Int) -> Void)?
}

// MARK: - TableView Delegate

extension WeatherDiaryViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
