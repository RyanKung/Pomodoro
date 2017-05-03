//
//  ViewController.swift
//  Pomodoro
//
//  Created by Ryan Kung on 2/5/2017.
//  Copyright © 2017 Ryan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var ctrlBtn: NSMenuItem!
    @IBOutlet weak var showingCtx: NSMenuItem!
    @IBOutlet weak var restWin: NSWindow!
    
    var restView = RestViewController(nibName: "RestViewController", bundle: Bundle.main)
    var status = "0" // 0 for pause, 1 for working, -1 for resting, all Strings.

    var startTime = Date()
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var timer:Timer!
    var delta:Float = 0.0
 
    
    func rest() {
        self.restView?.loadView()
        self.showingCtx.title = "Resting"
        self.status = "-1"
    }
    
    func work() {
        self.restView?.window.close()
        self.status = "1"
        self.delta = 0.0
    }
    
    func calcu() {
        print("calcu")
        print("status")
        var total: Double

        if self.status == "0" {
            self.startTime = Date()
            return
        }
        if self.status == "-1" {
            total = 30
        } else {
            total = 25
        }
        if self.status != "0" {
            self.delta = self.delta + Float(total - (Date().timeIntervalSince1970 - self.startTime.timeIntervalSince1970) / 60)
        }
        
        print("\(delta)")
        
        if self.delta <= 0{
            if self.status == "1" {
                return self.rest()
            } else {
                return self.work()
            }

        }
        let minutes = Int(self.delta)
        let seconds = Int((self.delta - Float(minutes)) * 60)
        
        if status == "-1" {
            self.restView?.text.title = "\(minutes):\(seconds)"
        } else {
            showingCtx.title = "\(minutes):\(seconds)"
        }
        self.delta = 0.0
    }
   
    override func awakeFromNib() {
//        let icon = NSImage(named: "statusIcon")
//        icon?.isTemplate = false // best for dark mode
//        statusItem.image = icon
        statusItem.title = "P"
        statusItem.menu = statusMenu
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target:self,selector:#selector(ViewController.calcu),
                                          userInfo:nil, repeats:true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startClicked(sender: NSMenuItem) {
        if self.ctrlBtn.title == "Start" {
            self.status = "1"
            self.startTime = Date()
            self.ctrlBtn.title = "Pause"
        } else {
            self.ctrlBtn.title = "Start"
            self.status = "0"
        }
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    
}
