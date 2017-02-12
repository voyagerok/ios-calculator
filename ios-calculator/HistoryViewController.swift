//
//  HistoryViewController.swift
//  ios-calculator
//
//  Created by Николай on 12.02.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    weak var expressionHandle: ExpressionHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expressionHandle.operationsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let targetCell = tableView.dequeueReusableCell(withIdentifier: "operationCell")
//        if let targetCell = tableView.dequeueReusableCell(withIdentifier: "operationCell") {
        let operationString = expressionHandle.operationsHistory[indexPath.row]
        targetCell?.textLabel?.text = operationString
        return targetCell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
