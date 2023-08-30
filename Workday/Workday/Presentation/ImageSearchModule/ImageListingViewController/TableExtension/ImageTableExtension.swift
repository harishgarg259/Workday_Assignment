//
//  ImageTableExtension.swift
//  Workday
//
//  Created by MSS Softprodigy on 28/08/23.
//

import Foundation
import UIKit

//MARK: UITableViewDelegate
extension ImageListingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailCell.nameId, for: indexPath) as! ImageDetailCell
        cell.configureCell(self.viewModel.records?[indexPath.row], mediaType: self.viewModel.mediaType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Check if data exist or not
        guard let data = self.viewModel.records?[indexPath.row] else {
            return
        }
        let controller = ImageDetailViewController.instantiate(fromAppStoryboard: .Main)
        controller.viewModel.detail = data
        controller.viewModel.mediaType = self.viewModel.mediaType
        self.pushTo(screen: controller,isAnimated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
}
