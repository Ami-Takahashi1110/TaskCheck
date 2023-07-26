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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                        title:  "戻る",
                        style:  .plain,
                        target: nil,
                        action: nil
                    )
    }
    // 保存ボタンを押下してテキストフィールドに入力した値をDBに登録する
    @IBAction func setDataButton(_ sender: Any) {
        // テキストフィールドから値を取得
        guard let valueToAddTask = taskTextField.text, !valueToAddTask.isEmpty else {
            // 値が空の場合は処理しない
                        return
        }
        guard let valueToAddExplanation = explanationTextField.text, !valueToAddExplanation.isEmpty else {
            // 値が空の場合は処理しない
                        return
        }
        guard let valueToAddDays = daysTextField.text, !valueToAddDays.isEmpty else {
            // 値が空の場合は処理しない
                        return
        }
        guard let valueToAddStartDate = startDate.text, !valueToAddStartDate.isEmpty else {
            // 値が空の場合は処理しない
                        return
        }
        guard let valueToAddCompleteDate = completeDateTextField.text, !valueToAddCompleteDate.isEmpty else {
            // 値が空の場合は処理しない
                        return
        }
        guard let valueToAddProgressDate = progressRateTextField.text, !valueToAddProgressDate.isEmpty else {
            // 値が空の場合は処理しない
                        return
        }
        guard let valueToAddMemo = memoTextField.text, !valueToAddMemo.isEmpty else {
            // 値が空の場合は処理しない
                        return
        }
        
        // Firebaseのデータベースに値を登録
        let db = Firestore.firestore()
        // ドキュメントに保存するデータの配列を作成
                let data: [String: Any] = [
                    "taskName": valueToAddTask,
                    "explanation": valueToAddExplanation,
                    "days": valueToAddDays,
                    "startDate": valueToAddStartDate,
                    "completionDate": valueToAddCompleteDate,
                    "progressRate": valueToAddProgressDate,
                    "memo": valueToAddMemo
                ]
        db.collection("task").addDocument(data: data) { error in
            if let error = error {
                print("データベースへの登録中にエラーが発生しました")
            } else {
                print("データベースへの登録が成功しました")
                print("data: \(data)")
                let tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "showTableViewController") as! TableViewController
                self.present(tableViewController, animated: true, completion: nil)
            }
        }
    }
}
