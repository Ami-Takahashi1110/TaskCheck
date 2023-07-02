//
//  ViewController.swift
//  TaskCheck
//
//  Created by USER on 2023/06/04.
//

import UIKit
import FirebaseFirestore


class ViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var explanationTextField: UITextField!
    
    @IBOutlet weak var daysTextField: UITextField!
    
    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var completeDateTextField: UITextField!
    
    @IBOutlet weak var progressRateTextField: UITextField!
       
    @IBOutlet weak var memoTextField: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 保存ボタンを押下してテキストフィールドに入力した値をDBに登録する
    @IBAction func setDataButton(_ sender: Any) {
        let db = Firestore.firestore()
        // どのコレクションに登録するか？
        let taskData = db.collection("task").document()
        
        // 配列を作成する
        // 項目はタスク名、説明、日数、完了日、進捗率、備考
        var task: [Task] = [] // データを保持する配列
        
        

        // 作成した配列に基づいたデータをセットする
        // 取得するデータはfirestoreから
        //taskData.setData([
            // ...
        //])

    }
    func setData(){
    }
    
    
    
    
}
