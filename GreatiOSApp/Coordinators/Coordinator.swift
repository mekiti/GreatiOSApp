import Foundation
import SwiftUI

protocol Coordinator {
    associatedtype ContentView: View
    func start() -> ContentView
}
