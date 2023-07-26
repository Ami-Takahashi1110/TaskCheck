//
//  GraphViewController.swift
//  TaskCheck
//
//  Created by USER on 2023/06/04.
//

import UIKit
import Charts
import FirebaseFirestore


class GraphViewController: UIViewController {
    // 使用する変数の宣言
        var chartView: LineChartView!
        var chartDataSet: LineChartDataSet!
    // 今回使用するサンプルデータ
    var xAxis: [Int] = []
    var yAxisAll: [Double] = []
    var completionDate: [Date] = []
    var startDate: [Date] = []
    var progressRate: [Float] = []
    
    
    let calendar = Calendar.current



    // 縦軸の設定
    // 全タスクの合計工数の配列を作成する(completiondateとstartdateの差分の日数)
    // デバッグで確認
    func calculateDifference(startDate: [Date], completionDate: [Date]) -> [TimeInterval] {
        let yAxisAll = zip(startDate, completionDate).map { (start, end) in
            return end.timeIntervalSince(start)
        }
        return yAxisAll
    }
    
    // 横軸の設定
    // 完了日を取得して昇順にソート（年月まで取得などする）の差分をループ処理で入れる→配列に入れる
    func sortCompletionDate(){
        completionDate = completionDate.sorted(by: { (a, b) -> Bool in
            return a > b
        })
        
        let firstDate = completionDate[0]
        let firstMonth = Calendar.current.component(.month, from: firstDate)
        let lastDate = completionDate[completionDate.count - 1]
        let lastMonth = Calendar.current.component(.month, from: lastDate)
        
        for i in stride(from: firstMonth, to: lastMonth, by: 1){
            xAxis.append(i)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // グラフを表示する
        displayChart(data: yAxisAll)
        // displayChart(data: )
    }
    func displayChart(data: [Double]) {
        // グラフの範囲を指定する
        chartView = LineChartView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 400))
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()
        
        for (xValue, yValue) in data.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
            dataEntries.append(dataEntry)
        }
        // グラフにデータを適用
        chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")
        chartView.data = LineChartData(dataSet: chartDataSet)
        
        // X軸(xAxis)
        chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
        // Y軸(leftAxis/rightAxis)
        chartView.leftAxis.axisMaximum = 100 //y左軸最大値
        chartView.leftAxis.axisMinimum = 0 //y左軸最小値
        chartView.leftAxis.labelCount = 6 // y軸ラベルの数
        chartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
        
        view.addSubview(chartView)
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
