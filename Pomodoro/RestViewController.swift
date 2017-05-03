//
//  RestViewController.swift
//  Pomodoro
//
//  Created by Ryan Kung on 3/5/2017.
//  Copyright © 2017 Ryan. All rights reserved.
//

import Cocoa

class RestViewController: NSViewController, NSWindowDelegate{
    @IBOutlet weak var text: NSTextFieldCell!
    @IBOutlet weak var window: NSWindow!

  
    override func viewDidAppear() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    func windowWillClose(_ notification: Notification) {
        print("close")
    }

    
}
