//
//  Benchmark.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/10/07.
//

import Foundation

class Benchmark {

  // 開始時刻を保存する変数
  var startTime: NSDate
  var key: String

  // 処理開始
  init(key: String) {
    self.startTime = NSDate()
    self.key = key
  }

  // 処理終了
  func finish() {
    let elapsed = NSDate().timeIntervalSince(self.startTime as Date) as Double
    let formatedElapsed = String(format: "%.3f", elapsed)
    print("Benchmark: \(key), Elasped time: \(formatedElapsed)(s)")
  }

  // 処理をブロックで受け取る
  class func measure(key: String, block: () -> ()) {
    let benchmark = Benchmark(key: key)
    block()
    benchmark.finish()
  }
}
