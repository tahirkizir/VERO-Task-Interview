//
//  ItemViewController.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 16.03.2023.
//

import UIKit

class ItemViewController: UIViewController
{
    private var itAr : [(String,Any)]?
    {
        didSet
        {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView : UITableView =
    {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor(named:"multiColorBaseWhite")
        tv.rowHeight = UITableView.automaticDimension
        tv.register(ItemDetailCell.self, forCellReuseIdentifier: "cellDetail")
        tv.estimatedRowHeight = 60
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = UIColor(named:"multiColorBaseWhite")
        
        return tv
    }()
    
    private lazy var backView : UIView =
    {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named:"multiColorBaseWhite")
        
        view.addSubview(backButton)
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 17.5).isActive = true
        backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(backLabel)
        backLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor,constant: 10).isActive = true
        backLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        
        return view
    }()
    
    private let backLabel : UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named:"multiColorBaseBlack")
        label.text = "Back"
        return label
    }()
    
    private lazy var backButton : UIButton =
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toBack), for: UIControl.Event.allTouchEvents)
        button.setImage(UIImage(named:"multiColorArrowBack"), for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return button
    }()
    
    @objc func toBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    func setItem(_ item:Item)
    {
        let tAr = [("Item: ",item.title),("Parent task id: ",item.parentTaskID),("Business unit key: ",item.BusinessUnitKey),("Business unit: ",item.businessUnit),("Color code: ",item.colorCode),("Description: ",item.description),("Is available in time tracking kiosk mode: ",item.isAvailableInTimeTrackingKioskMode),("Parent task id: ",item.parentTaskID),("Pre planning board quick select: ",item.preplanningBoardQuickSelect),("Sort: ",item.sort),("Task: ",item.task),("Title: ",item.title),("Wage type: ",item.wageType),("Working time: ",item.workingTime)] as [(String,Any)]
        self.itAr = tAr
    }
    
    func configureUI()
    {
        view.backgroundColor = UIColor(named:"multiColorBaseWhite")
        
        view.addSubview(backView)
        backView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        configureUI()
        

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ItemViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! ItemDetailCell
        
        cell.setCell(itAr![indexPath.row])
        
        return cell
    }
}
