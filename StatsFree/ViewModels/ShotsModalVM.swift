import Foundation

class ShotsModalVM {
    private var _timestamp:Float
    
    init(ytWindow: YTWrapper) {
        self._timestamp = 0.0
        ytWindow.getTime(handler: { result, err in
            self._timestamp = result
        })
    }
    
    public var timestamp: Float {
        return self._timestamp
    }
}
