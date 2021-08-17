/*
 * Copyright @ 2017-present 8x8, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import JitsiMeetSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var videoButton: UIButton?
    @IBOutlet weak var roomName: UITextField!
    
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultOptions = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            // for JaaS replace url with https://8x8.vc
            builder.serverURL = URL(string: "https://meet.jit.si")
            // for JaaS use the obtained Jitsi JWT
            // builder.token = "SampleJWT"
                
            builder.audioOnly = false
            builder.audioMuted = false
            builder.videoMuted = false
            builder.welcomePageEnabled = false
            // Set different feature flags
            builder.setFeatureFlag("toolbox.enabled", withBoolean: false)
            builder.setFeatureFlag("filmstrip.enabled", withBoolean: false)
        }
        
        JitsiMeet.sharedInstance().defaultConferenceOptions = defaultOptions
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.cleanUp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let barVC = segue.destination as? UITabBarController {
             barVC.viewControllers?.forEach {
                if #available(iOS 13.0, *) {
                    if let vc = $0 as? MeetingRoomViewController {
                        vc.view = jitsiMeetView
                    }
                } else {
                    // Fallback on earlier versions
                }
             }
         }
        
    }
    
    @IBAction func openJitsiMeet(sender: Any?) {
        let room: String = roomName.text!
        if(room.count < 1) {
            return
        }
        
        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            // for JaaS use <tenant>/<roomName> format
            builder.userInfo?.email = "sts.cgame@gmail.com"
            // builder.userInfo?.avatar = URL(fileURLWithPath: "")
            builder.userInfo?.displayName = "Z64me"
            builder.room = room
            builder.audioOnly = true
            // Settings for audio and video
            // builder.audioMuted = true;
            // builder.videoMuted = true;
        }
                
        // setup view controller
        // let vc = MeetingRoomViewController()
        // vc.modalPresentationStyle = .formSheet
        // vc.view = jitsiMeetView
        
        // join room and display jitsi-call
        jitsiMeetView.join(options)
        self.jitsiMeetView = jitsiMeetView
       performSegue(withIdentifier: "meetingRoom", sender: self)
    }
    
    fileprivate func cleanUp() {
        if(jitsiMeetView != nil) {
            jitsiMeetView?.leave()
            dismiss(animated: true, completion: nil)
            jitsiMeetView = nil
        }
    }
}

extension ViewController: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        self.cleanUp()
    }
}
