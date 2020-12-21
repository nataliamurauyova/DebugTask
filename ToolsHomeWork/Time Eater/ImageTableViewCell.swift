//
//  ImageTableViewCell.swift
//  ToolsHomeWork
//
//  Created by Nataliya Murauyova on 12/21/20.
//  Copyright © 2020 Igor Kupreev. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        cellImage.image = nil
    }
    
}
