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
    let memo: String
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    // 配列を作成する
    // 項目はタスク名、説明、日数、完了日、進捗率、備考
    var task: [Task] = [] // データを保持する配列
    var completionDates: [Date] = []
    var startDates: [Date] = []
    var completionTask: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // セルの登録
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        // データの取得
        getData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func graphButtonAction(_ sender: Any) {
        // 4. 画面遷移実行
              performSegue(withIdentifier: "toGraphController", sender: nil)
    }
    // segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueのIDを確認して特定のsegueのときのみ動作させる
        if segue.identifier == "toGraphController" {
            // 2. 遷移先のViewControllerを取得
            let next = segue.destination as? GraphViewController
            // 3. １で用意した遷移先の変数に値を渡す
            next?.completionDate = completionDates
            next?.startDate = startDates
        }
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                // エラーダイアログを表示
                let message = "タスクが入力されていません。登録画面に戻ります。"
                showErrorDialog(message: message)
                // 登録画面への遷移処理を実行
                navigateToRegistrationScreen()
                
                // エラーダイアログを表示するメソッド
                func showErrorDialog(message: String) {
                    let alertController = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                // 登録画面へ遷移するメソッド
                func navigateToRegistrationScreen() {
                    // 登録画面への遷移処理を記述
                    
                }

                
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    // 必要なデータを取り出してUserオブジェクトを作成
                    if let taskName = document.data()["taskName"] as? String,
                       let explanation = document.data()["explanation"] as? String,
                       let days = document.data()["days"] as? String,
                       let startDate = document.data()["startDate"] as? Date,
                       let completionDate = document.data()["completionDate"] as? Date,
                       let progressRate = document.data()["progressRate"] as? Float,
                       let memo = document.data()["memo"] as? String
                    {
                        let user = Task(taskName: taskName,
                                        explanation: explanation,
                                        days:days,
                                        startDate:startDate,
                                        completionDate:completionDate,
                                        progressRate:progressRate,
                                        memo: memo
                        )
                        self.task.append(user)
                        self.completionDates.append(completionDate)
                        self.startDates.append(startDate)
                    }
                }
                // TableViewを更新
                self.tableView.reloadData()
                // 日付でソートしたタスクから完了率が100パーセントのタスクを取り出すオブジェクトを作成
                self.task = self.task.sorted(by: { (a, b) -> Bool in
                        return a.completionDate > b.completionDate
                    })
                for data in self.task {
                    if data.progressRate == 100 {
                        let differences = data.completionDate.timeIntervalSince(data.startDate)
                        self.completionTask.append(differences)
                    }
                }

                
                
            }
        }
    }


     // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
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
