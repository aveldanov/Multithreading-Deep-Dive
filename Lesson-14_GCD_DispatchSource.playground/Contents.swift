//LESSON 14 - GCD Dispatch Source

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true



let timer = DispatchSource.makeTimerSource(queue: .global())

timer.setEventHandler {
    print("Timer is DONE")
}


timer.schedule(deadline: .now(), repeating: 5)
timer.activate()
