//
//  ViewController.swift
//  MultiiOST
//
//  Created by Nikolas Omelianov on 21.06.2022.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController {

    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .optional)
        mcSession.delegate = self
    }
    

    func sendImage(img: UIImage) {
        if mcSession.connectedPeers.count > 0 {
            if let imageData = img.pngData() {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    }
    
    func startHosting(action: UIAlertAction!) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "nik-kb", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
    }

    func sendText(txt: String) {
        if mcSession.connectedPeers.count > 0 {
            if let dt = txt.data(using: .utf8)  {
                do {
                    try mcSession.send(dt, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    }
    
    func joinSession(action: UIAlertAction!) {
        let mcBrowser = MCBrowserViewController(serviceType: "nik-kb", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    @IBAction func startTapped(_ sender: UIButton) {
        startHosting(action: .none)
    }
    @IBAction func joinTapped(_ sender: UIButton) {
        joinSession(action: .none)
    }
    
    @IBAction func sendTapped(_ sender: UIButton) {
        sendText(txt: "\(Int.random(in: 0...9))")
    }
    
    
}

extension ViewController: MCSessionDelegate, MCBrowserViewControllerDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print(#function,  #line)
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")

        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")

        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print(#function,  #line)
        if let image = UIImage(data: data) {
                DispatchQueue.main.async { [unowned self] in
                    // do something with the image
                }
            }
        if let txt = String(data: data, encoding: .utf8)  {
            print("data is --> ", txt)
        }
    }
    
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print(#function,  #line)
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print(#function,  #line)
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print(#function,  #line)
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        print(#function,  #line)
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        print(#function,  #line)
        dismiss(animated: true)
    }
    
}
