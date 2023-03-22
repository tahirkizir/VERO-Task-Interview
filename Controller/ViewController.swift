
//
//  ViewController.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 10.03.2023.
//

import UIKit

class ViewController: UIViewController
{
    
    private var user : User?
    private var session : Session?
    private var itemList = [Item]()
    private var searchList = [Item]()
    private let coreData = CoreData()
    private let network = Network()
    private let event = Event()
    private var accessToken : String?
    {
        didSet
        {
            tableView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    private var queryActive = false
    private var st = 0

    private lazy var refreshControl : UIRefreshControl =
    {
        let rc = UIRefreshControl()
        rc.translatesAutoresizingMaskIntoConstraints = false
        rc.tintColor = UIColor(named: "multiColorBaseBlack")
        rc.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return rc
    }()
    
    private lazy var tableView : UITableView =
    {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor(named:"multiColorBaseWhite")
        tv.rowHeight = UITableView.automaticDimension
        tv.register(ItemCell.self, forCellReuseIdentifier: "cell")
        tv.estimatedRowHeight = 60
        tv.refreshControl = refreshControl
        tv.addSubview(refreshControl)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var searchBar : UISearchBar =
    {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Enter your query"
        searchBar.barStyle = .default
        searchBar.delegate = self
        return searchBar
    }()
    
    private let activityIndicator : UIActivityIndicatorView =
    {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        ai.style = .medium
        ai.tintColor = UIColor(named: "multiColorBaseBlack")
        return ai
    }()
    
    private let qrCodeImage : UIImageView =
    {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "multiColorQRCode")
        img.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img.heightAnchor.constraint(equalToConstant: 25).isActive = true
        img.isUserInteractionEnabled = true
        return img
    }()
    
    @objc func pullToRefresh()
    {
        refreshControl.beginRefreshing()
        network.requestResource(accessToken!) { [self] getSuccess, errorCode, list in
            
            if getSuccess
            {
                itemList = list!
                tableView.reloadData()
            }
            else
            {
                present(event.showError(nil,errorCode!), animated: false)
            }
            refreshControl.endRefreshing()
        }
    }
    
    @objc func qrTapped()
    {
        let vc = ScannerViewController()
        
        present(vc, animated: false)
    }
    
    func configureUI()
    {
        view.backgroundColor = UIColor(named:"multiColorBaseWhite")
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(qrCodeImage)
        qrCodeImage.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        qrCodeImage.rightAnchor.constraint(equalTo: searchBar.rightAnchor,constant: -20).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(qrTapped))
        qrCodeImage.addGestureRecognizer(tap)
        activityIndicator.startAnimating()
        
    }
    
    func setC(_ itList:[Item],_ se:Session,_ us:User,_ at:String)
    {
        itemList = itList
        session = se
        user = us
        accessToken = at
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureUI()
        
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (queryActive) ? searchList.count : itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ItemCell
        let i = (queryActive) ? searchList[indexPath.row] : itemList[indexPath.row]
        cell.setCell(i)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = ItemViewController()
        (queryActive) ? vc.setItem(searchList[indexPath.row]) : vc.setItem(itemList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.count == 0
        {
            queryActive = false
            searchBar.searchTextField.resignFirstResponder()
            tableView.reloadData()
        }
        st = searchText.count
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let searchResults = itemList.filter({ (it:Item) -> Bool in
        let descriptionMatch = it.description.range(of: searchBar.text!,options:.caseInsensitive)
        let workingTimeMatch = it.workingTime.range(of: searchBar.text!,options: .caseInsensitive)
        let wageType = it.wageType.range(of: searchBar.text!,options: .caseInsensitive)
        let title = it.title.range(of: searchBar.text!,options: .caseInsensitive)
        let task = it.task.range(of: searchBar.text!,options: .caseInsensitive)
        let sort = it.sort.range(of: searchBar.text!,options: .caseInsensitive)
        let preplanningBoardQuickSelect = it.preplanningBoardQuickSelect.range(of: searchBar.text!,options: .caseInsensitive)
        let parentTaskID = it.parentTaskID.range(of: searchBar.text!,options: .caseInsensitive)
        let isAvailableInTimeTrackingKioskMode = "\(it.isAvailableInTimeTrackingKioskMode)".range(of: searchBar.text!,options: .caseInsensitive)
        let colorCode = it.colorCode.range(of: searchBar.text!,options: .caseInsensitive)
        let businessUnit = it.businessUnit.range(of: searchBar.text!,options: .caseInsensitive)
        let BusinessUnitKey = it.BusinessUnitKey.range(of: searchBar.text!,options: .caseInsensitive)
        
        return descriptionMatch != nil || workingTimeMatch != nil || wageType != nil || title != nil || task != nil || sort != nil || preplanningBoardQuickSelect != nil || parentTaskID != nil || isAvailableInTimeTrackingKioskMode != nil || colorCode != nil || businessUnit != nil || BusinessUnitKey != nil
        })
        queryActive = true
        searchList = searchResults
        searchBar.searchTextField.resignFirstResponder()
        tableView.reloadData()
    }
}

