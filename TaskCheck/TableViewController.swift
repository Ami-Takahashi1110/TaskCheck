//
//  TableViewController.swift
//  TaskCheck
//
//  Created by USER on 2023/06/10.
//

import UIKit
import FirebaseFirestore

// 取得するデータのカラムに変数を用意する
struct Task {
    let taskName: String
    let explanation: String
    let days: String
    let startDate: Date
    let completionDate: Date
    let progressRate: Float
}

class TableViewController: UITableViewController{

    // 配列を作成する
    // 項目はタスク名、説明、日数、完了日、進捗率、備考
    var task: [Task] = [] // データを保持する配列
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // セルの登録
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        // データの取得
        getData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as!TableViewCell

        // userに格納したデータをセルに表示する
        cell.img.image = UIImage(systemName: "swift")
        cell.taskName.text = task[indexPath.row].taskName
        cell.contents.text = task[indexPath.row].explanation
        cell.progress.progress = task[indexPath.row].progressRate

        return cell
    }
    
    // データを取得する
    func getData(){
        let db = Firestore.firestore()
        db.collection("task").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("データの取得に失敗しました: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    // 必要なデータを取り出してUserオブジェクトを作成
                    if let taskName = document.data()["taskName"] as? String,
                       let explanation = document.data()["explanation"] as? String,
                       let days = document.data()["days"] as? String,
                       let startDate = document.data()["startDate"] as? Date,
                       let completionDate = document.data()["completionDate"] as? Date,
                       let progressRate = document.data()["progressRate"] as? Float
                    {
                        let user = Task(taskName: taskName,
                                        explanation: explanation,
                                        days:days,
                                        startDate:startDate,
                                        completionDate:completionDate,
                                        progressRate:progressRate)
                        self.task.append(user)
                    }
                }
                // TableViewを更新
                self.tableView.reloadData()
            }
        }
    }


     // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         //Return false if you do not want the specified item to be editable.
        return true
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
