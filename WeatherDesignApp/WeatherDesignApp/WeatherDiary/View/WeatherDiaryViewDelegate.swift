//
//  WeatherDiaryViewDelegate.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation
import UIKit

class WeatherDiaryViewDelegate: NSObject {
    
}

extension WeatherDiaryViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        //self.routeToEditNote(forIndexPath: indexPath.row)
    }
}
