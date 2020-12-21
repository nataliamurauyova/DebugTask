//
//  TimeEaterFlowController.swift
//  MealTime
//
//  Created by Igor Kupreev on 9/16/18.
//  Copyright © 2018 Igor Kupreev. All rights reserved.
//

import UIKit


class TimeEaterFlowController: UIViewController {

    @IBOutlet private var table: UITableView!
    var files = [String]()

    private let cellId = "ImageTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: cellId, bundle: Bundle.main), forCellReuseIdentifier: cellId)

        let fm = FileManager.default
        if let path = Bundle.main.resourcePath,
            let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items where item.hasPrefix("img") {
                files.append(item)

                // Adding all the images to cache
                let imagePath = Bundle.main.path(forResource: item, ofType: "") ?? ""
                if let img = UIImage(contentsOfFile: imagePath) {
                    MemoryCache.shared.set(img, forKey: imagePath)
                }
            }
        }

        table.reloadData()
    }
}


extension TimeEaterFlowController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ImageTableViewCell {
            let file = files[indexPath.row]
            let path = Bundle.main.path(forResource: file, ofType: "") ?? ""

            cell.cellImage.image = MemoryCache.shared.image(forKey: path)
        }
    }
}

extension TimeEaterFlowController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let details = TimeEaterChildViewController()
        
        details.file = files[indexPath.row]
        
        navigationController?.pushViewController(details, animated: true)
    }
}
