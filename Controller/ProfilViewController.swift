//
//  ProfilViewController.swift
//  VERO-Digital-Solutions-Tahir-Kizir-Interview
//
//  Created by Tahir Kizir on 16.03.2023.
//

import UIKit

class ProfilViewController: UIViewController
{
    var ptAr = [(String,Any,Bool)]()
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
        tv.register(ProfilCell.self, forCellReuseIdentifier: "cellProfil")
        tv.estimatedRowHeight = 60
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    func configureUI()
    {
        view.backgroundColor = UIColor(named:"multiColorBaseWhite")
        tableView.backgroundColor = UIColor(named:"multiColorBaseWhite")
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setPC(_ user:User)
    {
        var permissions="";for i in user.permissions {permissions += "\(i), "}; permissions.removeLast();permissions.removeLast()
        let pt = [("Permissions: ",permissions,true),("Active: ",user.active,false),("Business unit: ",user.businessUnit,false),("Display name: ",user.displayName,false),("First name: ",user.firstName,false),("Last name: ",user.lastName,false),("Personal no: ",user.personalNo,false)] as [(String,Any,Bool)]
        ptAr = pt
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureUI()

        // Do any additional setup after loading the view.
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

extension ProfilViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ptAr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProfil", for: indexPath) as! ProfilCell
        
        cell.setCell(ptAr[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ptAr[indexPath.row].2 = !ptAr[indexPath.row].2
        tableView.reloadData()
    }

}
