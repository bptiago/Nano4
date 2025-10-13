//
//  StreamerSide.swift
//  nanoquatro
//
//  Created by Tiago Prestes on 13/10/25.
//

import Foundation
import MultipeerConnectivity

class MultipeerSession: NSObject {
  let serviceType = "morse"
  let peerID: MCPeerID
  let session: MCSession
  let advertiser: MCNearbyServiceAdvertiser
  let browser: MCNearbyServiceBrowser
  
  var onMessageReceived: ((String, MCPeerID) -> Void)?
  
  override init() {
    peerID = MCPeerID(displayName: UIDevice.current.name)
    session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
    advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
    browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
    
    super.init()
    session.delegate = self
    advertiser.delegate = self
    browser.delegate = self
    
    advertiser.startAdvertisingPeer()
    browser.startBrowsingForPeers()
  }
  
  func sendMessage(_ message: String) {
    guard !session.connectedPeers.isEmpty else { return }
    if let data = message.data(using: .utf8) {
      do {
        try session.send(data, toPeers: session.connectedPeers, with: .reliable)
      } catch {
        print("Error sending message: \(error.localizedDescription)")
      }
    }
  }
  
  func disconnect() {
    advertiser.stopAdvertisingPeer()
    session.disconnect()
  }
}

extension MultipeerSession: MCSessionDelegate {
  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    print("Peer \(peerID.displayName) changed state: \(state.rawValue)")
  }
  
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    if let message = String(data: data, encoding: .utf8) {
      DispatchQueue.main.async {
        self.onMessageReceived?(message, peerID)
      }
    }
  }
  
  // Não precisam ser implementadas
  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
}

extension MultipeerSession: MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
  
  func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    print("Found peer: \(peerID.displayName)")
    //        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
  }
  
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    print("Lost peer: \(peerID.displayName)")
  }
  
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID,
                  withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    print("Received invitation from \(peerID.displayName)")
    //        invitationHandler(true, session)
  }
}
