//
//  ViewController.swift
//  LLALogManagerDemoTvOS
//
//  Created by Daisuke T on 2019/02/11.
//  Copyright © 2019 LLALogManagerDemoTvOS. All rights reserved.
//

import UIKit

import LLALogManager

class ViewController: UIViewController {
  
  static let levelMap:[LLALogManager.Level:String] = [
    LLALogManager.Level.debug  : "DEB",
    LLALogManager.Level.info  : "INF",
    LLALogManager.Level.warn  : "WAR",
    LLALogManager.Level.error  : "ERR",
    LLALogManager.Level.fatal  : "FAT",
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let llalog = LLALogManager.sharedInstance
    
    
    #if DEBUG
    #else
    llalog.level = LLALogManager.Level.info
    #endif
    
    llalog.i("Version \(llalog.version)")
    let level: LLALogManager.Level = llalog.level
    
    
    // Log Level.
    print("\nLEVEL")
    llalog.d("Information for developers.")
    llalog.i("Generic information.")
    llalog.w("Warning.")
    llalog.e("Error(Possible continue).")
    llalog.f("Fatal(Impossible continue).")
    
    print("\nChange log level to ERROR")
    llalog.level = LLALogManager.Level.error
    llalog.d("Information for developers.")  // Log will not output.
    llalog.i("Generic information.")    // Log will not output.
    llalog.w("Warning.")          // Log will not output.
    llalog.e("Error(Possible continue).")
    llalog.f("Fatal(Impossible continue).")
    
    llalog.level = level
    
    
    // Change log level string.
    print("\nLOG LEVEL STRING")
    llalog.levelMap = ViewController.levelMap
    llalog.d("DEBUG")
    llalog.i("INFO")
    llalog.w("WARN")
    llalog.e("ERROR")
    llalog.f("FATAL")
    llalog.levelMap = LLALogManager.defaultLevelMap
    
    
    // Change separate string.
    print("\nSEPARATOR")
    llalog.i("Default", "separator", "is", "space.")
    
    llalog.separator = "⭐️"
    llalog.i("Custom", "separator", "is", ".")
    
    llalog.separator = LLALogManager.defaultSeparator
    
    
    // Change date format.
    print("\nDATE FORMAT")
    llalog.i("Default date format is \"\(llalog.dateFormat)\".")
    
    llalog.dateFormat = "MM/dd(EEE)"
    llalog.i("Custom date format is \"\(llalog.dateFormat)\".")
    
    llalog.dateFormat = LLALogManager.defaultDateFormat
    
    
    // Change log format
    print("\nLOG FORMAT")
    llalog.delegate = self
    llalog.i("Custom log format.")
    llalog.delegate = nil
    
    
    // Thread Test.
    llalog.isThreadingEnable = true
    for i in 0..<UInt8.max {
      llalog.i(i)
    }
    
    llalog.isThreadingEnable = false
    llalog.i("😀")
  }
  
  
}


extension ViewController : LLALogManagerDelegate {
  func log(_ data: LLALogManager.Data) {
    print("\(data.level) \(data.index) \(data.fileName) \(data.function):\(data.line)\t --- ", terminator: "")
    
    var separator = ""
    for elm in data.items {
      
      print(separator, terminator: "")
      print(elm, terminator: "")
      
      separator = " "
      
    }
  }
  
}
