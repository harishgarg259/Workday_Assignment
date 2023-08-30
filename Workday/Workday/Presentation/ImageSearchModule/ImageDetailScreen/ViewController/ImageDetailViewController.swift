//
//  ImageDetailViewController.swift
//  Workday
//
//  Created by Harish Garg on 28/08/23.
//

import Foundation
import UIKit

class ImageDetailViewController: UIViewController {

    //MARK: IBoutlets
    @IBOutlet weak var searchedImageView: UIImageView!
    @IBOutlet var imageTitleLabel: UILabel!
    @IBOutlet var imageDateLabel: UILabel!
    @IBOutlet var imageDescriptionLabel: UILabel!
    
    //MARK: Variables
    var viewModel = ImageDetailViewModel()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK: Private Default Methods
extension ImageDetailViewController {
    
    private func setupUI() {
        setupNavigationBar()
        configureImageDetail()
    }
    
    private func setupNavigationBar() {
        //Set title
        self.title = "Image Detail"
    }
    
    private func configureImageDetail() {
        
        //Check if data exist or not
        guard let data = viewModel.detail?.filterData(type: self.viewModel.mediaType) else {
            return
        }
        self.imageTitleLabel.text = data.title ?? "Nasa's Image"
        self.imageDateLabel.text = (data.date_created ?? "").getFormattedDate(format: .mmmdCommayyyy)
        self.imageDescriptionLabel.text = data.description ?? "Image Description"
        
        //Check image url exist or not
        guard let link = viewModel.detail?.filterLink(type: self.viewModel.mediaType) else {
            return
        }
        //Load image using ImageLoader factory
        ImageLoader.sharedLoader.imageForUrl(urlString: link.href, placeholder: "logo", completionHandler:{(image: UIImage?, url: String) in
            self.searchedImageView.image = image
        })
    }
}
