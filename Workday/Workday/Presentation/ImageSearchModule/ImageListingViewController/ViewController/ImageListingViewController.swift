//
//  ViewController.swift
//  Workday
//
//  Created by Harish Garg on 26/08/23.
//

import UIKit

class ImageListingViewController: UIViewController {

    //MARK: IBoutlets
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var searchedImagesTableView: PagingTableView!
    @IBOutlet weak var noRecordView: UIView!
    
    //MARK: Variables
    let viewModel = SearchImageViewModel()
    private let refreshControl = UIRefreshControl()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: Private Default Methods
extension ImageListingViewController {
    
    private func setupUI() {
        setupNavigationBar()
        configureTableView()
        setupRefreshControl()
    }
    
    private func setupNavigationBar() {
        
        //Set title
        self.title = "Search Images"
        
        //Set media type Search
        self.viewModel.mediaType = .Image
        
        //Setup Pagination Delegates
        searchedImagesTableView.pagingDelegate = self

        //Search field callback
        searchTextField.userStoppedTypingHandler = { [weak self] in
            if self?.searchTextField.hasText() ?? false {
                // Fetch record from API
                self?.searchTextField.showLoadingIndicator()
                self?.searchRecords(searchString: self?.searchTextField.text ?? "", page: 1)
            }else{
                self?.viewModel.records.removeAll()
                self?.reloadView()
            }
        } as (() -> Void)
    }
    
    private func configureTableView() {
        searchedImagesTableView.registerCell(ImageDetailCell.self)
    }
    
    private func reloadView(){
        searchedImagesTableView.isLoading = false
        self.noRecordView.isHidden = (self.searchTextField.text?.isEmpty ?? true) ? true : !self.viewModel.records.isEmpty
        self.refreshControl.endRefreshing()
        self.searchedImagesTableView.reloadData()
        self.searchTextField.stopLoadingIndicator()
    }
    
    private func setupRefreshControl(){
        refreshControl.addTarget(self, action: #selector(refreshSearchData), for: .valueChanged)
        self.searchedImagesTableView.refreshControl = refreshControl
    }
    
    @objc func refreshSearchData(refreshControl: UIRefreshControl) {
        if self.searchTextField.hasText() {
            searchRecords(searchString: self.searchTextField.text ?? "", page: 1)
        }else{
            self.refreshControl.endRefreshing()
        }
    }
    
}

//MARK: Apis Call
extension ImageListingViewController
{
    private func searchRecords(searchString:String, page: Int)
    {
        //Check if it a fresh request then reset page and current count
        if page == 1{
            searchedImagesTableView.resetCount()
        }
        
        self.viewModel.searchImages(searchString: searchString, page: page) { [weak self](images,success,error) in
            DispatchQueue.main.async {
                //Error Alert
                if !success {
                    self?.showAlert(withMessage: error)
                }
                self?.reloadView()
            }
        }
    }
}

//MARK: PagingTableViewDelegate
extension ImageListingViewController: PagingTableViewDelegate {
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        if self.searchTextField.hasText() {
            searchedImagesTableView.isLoading = true
            searchRecords(searchString: self.searchTextField.text ?? "", page: page + 1)
        }else{
            self.refreshControl.endRefreshing()
        }
    }
    
}
