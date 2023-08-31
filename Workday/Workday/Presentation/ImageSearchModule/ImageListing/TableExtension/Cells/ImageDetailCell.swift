//
//  ImageDetailCell.swift
//  Workday
//
//  Created by Harish Garg on 28/08/23.
//

import UIKit

class ImageDetailCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var searchedImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - UITableViewCell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        //Set image to default before reusing
        self.searchedImageView.image = UIImage(systemName: "photo")
        super.prepareForReuse()
    }
    
    //MARK: - Configure Cell
    func configureCell(_ detail: Items?, mediaType: Media) {
        
        //Check if data exist or not
        guard let data = detail?.filterData(type: mediaType) else {
            return
        }
        self.titleLabel.text = data.title ?? "Nasa's Image"
//        let detailLabel = (data.description ?? "Image Description").prefix(100)
        self.detailLabel.text = (data.description ?? "Image Description")
        
        //Check image url exist or not
        guard let link = detail?.filterLink(type: mediaType) else {
            return
        }
        //Load image using ImageLoader factory
        ImageLoader.sharedLoader.imageForUrl(urlString: link.href, placeholder: "logo", completionHandler:{(image: UIImage?, url: String) in
            self.searchedImageView.image = image
        })
    }
    
    
}
