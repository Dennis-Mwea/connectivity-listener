//
//  Connection.swift
//  background_listeners
//
//  Created by Dennis Mwea on 02/03/2023.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    var reachability: Reachability!
    private let notification = Notification.Name("NetworkListenerStatusDidChanged")
    /// Return true if connected to Internet
    private(set) var isConnected: Bool!

    static let sharedInstance: NetworkManager = { return NetworkManager() }()
    
    override init() {
        reachability = try! Reachability()
        
        super.init()
        
        // initialize connection state
        isConnected = reachability.connection != .unavailable

        NotificationCenter.default.addObserver(
            forName: .reachabilityChanged,
            object: nil,
            queue: OperationQueue.main
        ) { [weak self] notification in
            guard let self = self else { return }
            let newConnectionState = self.reachability.connection != .unavailable
                    
            if self.isConnected != newConnectionState {
                self.isConnected = newConnectionState
                NotificationCenter.default.post(name: self.notification, object: nil)
            }
        }
    
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: notification, object: nil)
    }
    
    /// Start monitoring network status changed
    ///
    /// - Parameter networkStatusDidChange: status changed callback
    func observeNetworkStatusChanged(completion: @escaping (Bool) -> Void) {
        NotificationCenter.default.addObserver(forName: notification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            guard let self = self else { return }
            completion(self.isConnected)
        }
    }
}
