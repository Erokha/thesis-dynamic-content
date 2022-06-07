import Foundation

struct TimeRecord {
    let size: Int
    let time: Double
}

class TimeResultCalculator {
    private struct InternalTimeRecord {
        let size: Int
        var time: Double
        var numberOfRecords: Int
        
        init(from record: TimeRecord) {
            self.size = record.size
            self.time = record.time
            self.numberOfRecords = 1
        }
        
        init(
            size: Int,
            time: Double,
            numberOfRecords: Int
        ) {
            self.size = size
            self.time = time
            self.numberOfRecords = numberOfRecords
        }
    }
    
    private var _results: [InternalTimeRecord] = []
    
    var results: [TimeRecord] {
        _results.map { TimeRecord(size: $0.size, time: $0.time / Double($0.numberOfRecords)) }
    }
    
    func record(result: TimeRecord) {
        guard let numberOfRecord = _results.firstIndex(where: { $0.size == result.size }) else {
            _results.append(InternalTimeRecord(from: result))
            return
        }
        
        _results[numberOfRecord].time += result.time
        _results[numberOfRecord].numberOfRecords += 1
    }
}

