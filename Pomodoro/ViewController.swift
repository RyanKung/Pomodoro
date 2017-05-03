//
//  ViewController.swift
//  Pomodoro
//
//  Created by Ryan Kung on 2/5/2017.
//  Copyright © 2017 Ryan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSMenuDelegate{
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var ctrlBtn: NSMenuItem!
    @IBOutlet weak var showingCtx: NSMenuItem!
    @IBOutlet weak var restWin: NSWindow!
    var restView = RestViewController(nibName: "RestViewController", bundle: Bundle.main)
    var status = "0" // 0 for Stop, 1 for working, -1 for resting, all Strings.
    var startTime = Date()
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var timer:Timer!
    var delta:Float = 0.0
    
 
    func menuNeedsUpdate(_ menu: NSMenu) {
        print("updated")
    }
    func stop() {
        self.ctrlBtn.title = "Start"
        self.showingCtx.title = "--:--"
        if (self.restView?.isViewLoaded)! {
            self.restView?.window.close()
        }
        self.status = "0"
    }

    
    func rest() {
        self.restView?.loadView()
        self.status = "-1"
    }
    
    func work() {
        self.startTime = Date()
        self.ctrlBtn.title = "Stop"
        if (self.restView?.isViewLoaded)! {
            self.restView?.window.close()
        }
        self.status = "1"
    }
    
    func calcu() {
        var total: Double

        if self.status == "0" {
            return
        }
        if self.status == "-1" {
            total = 30
        } else {
            total = 25
        }
        self.delta = Float(total - (Date().timeIntervalSince1970 - self.startTime.timeIntervalSince1970) / 60)
        
        if self.delta <= 0{
            if self.status == "1" {
                return self.rest()
            } else {
                return self.work()
            }

        }
        let minutes = Int(self.delta)
        var seconds = String(Int((self.delta - Float(minutes)) * 60))
        if seconds.characters.count < 2 {
            seconds = "0" + seconds
        }
        
        if status == "-1" {
            self.restView?.text.title = "\(minutes):\(seconds)"
        }
        self.showingCtx.title = "\(minutes):\(seconds)"
        self.statusItem.menu?.update()
    }
   
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
//        statusItem.title = "P"
        statusItem.menu = statusMenu
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target:self,selector:#selector(ViewController.calcu),
                                          userInfo:nil, repeats:true)
        RunLoop.main.add(self.timer, forMode: RunLoopMode.eventTrackingRunLoopMode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pauseClicked(sender: NSMenuItem) {

    }
    @IBAction func startClicked(sender: NSMenuItem) {
        if self.status == "0" {
            self.work()
        } else {
            self.stop() 
        }
    }
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    
}
