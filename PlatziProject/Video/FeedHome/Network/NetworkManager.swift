//
//  NetworkManager.swift
//  PlatziProject
//
//  Created by Mike Jasso on 12/07/24.
//

import Foundation
import Reachability
import Combine

class NetworkManager: ObservableObject {
    private var reachability: Reachability?
    @Published var isReachable: Bool = true
    
    init() {
        reachability = try? Reachability()
        
        reachability?.whenReachable = { [weak self] reachability in
            DispatchQueue.main.async {
                self?.isReachable = true
            }
        }
        reachability?.whenUnreachable = { [weak self] _ in
            DispatchQueue.main.async {
                self?.isReachable = false
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        reachability?.stopNotifier()
    }
}
