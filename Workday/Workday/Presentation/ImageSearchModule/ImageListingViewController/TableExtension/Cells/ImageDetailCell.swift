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
        //Set image to nil before reusing
        self.searchedImageView.image = nil
        super.prepareForReuse()
    }
    
    //MARK: - Configure Cell
    func configureCell(_ detail: Items?) {
        self.titleLabel.text = detail?.data?[safe: 0]?.title ?? "Nasa's Image"
        self.detailLabel.text = detail?.data?[safe: 0]?.description ?? "Image Description"
        
        //Check image url exist or not
        guard let urlString = detail?.links?[safe: 0]?.href, !urlString.isEmpty else {
            return
        }
        //Encode the URL before laoding to avoid crash
        let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        //Load image using ImageLoader factory
        ImageLoader.sharedLoader.imageForUrl(urlString: encodedURL, completionHandler:{(image: UIImage?, url: String) in
            self.searchedImageView.image = image
        })
    }
    
    
}
