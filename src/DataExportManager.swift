//
//  DataExportManager.swift
//  Cubit
//

import UIKit

class DataExportManager {
    
    enum ExportFormat {
        case csv
        case json
        case text
    }
    
    static func exportSession(_ session: Session, format: ExportFormat) -> String {
        switch format {
        case .csv:
            return exportToCSV(session)
        case .json:
            return exportToJSON(session)
        case .text:
            return exportToText(session)
        }
    }
    
    static func shareSession(_ session: Session, from viewController: UIViewController, format: ExportFormat = .csv) {
        let exportData = exportSession(session, format: format)
        let fileName = "\(session.name)_cubing_times.\(fileExtension(for: format))"
        
        // Create temporary file
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try exportData.write(to: tempURL, atomically: true, encoding: .utf8)
            
            let activityViewController = UIActivityViewController(
                activityItems: [tempURL],
                applicationActivities: nil
            )
            
            // iPad popover support
            if let popover = activityViewController.popoverPresentationController {
                popover.sourceView = viewController.view
                popover.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            
            viewController.present(activityViewController, animated: true)
            
        } catch {
            showErrorAlert(in: viewController, message: "Failed to export data: \(error.localizedDescription)")
        }
    }
    
    private static func exportToCSV(_ session: Session) -> String {
        var csv = "Solve,Time,Penalty,Scramble,Date\n"
        
        for (index, solve) in session.times.enumerated() {
            let penalty = solve.penalty == 0 ? "None" : (solve.penalty == 1 ? "+2" : "DNF")
            let scramble = index < session.scrambles.count ? session.scrambles[index] : "N/A"
            let date = ISO8601DateFormatter().string(from: Date()) // Simplified - would use actual solve date
            
            csv += "\(index + 1),\(solve.getMyString()),\(penalty),\"\(scramble)\",\(date)\n"
        }
        
        return csv
    }
    
    private static func exportToJSON(_ session: Session) -> String {
        var jsonData: [String: Any] = [
            "session_name": session.name,
            "event": session.scrambler.myEvent,
            "export_date": ISO8601DateFormatter().string(from: Date()),
            "solves": []
        ]
        
        var solves: [[String: Any]] = []
        
        for (index, solve) in session.times.enumerated() {
            let penalty = solve.penalty == 0 ? "none" : (solve.penalty == 1 ? "plus2" : "dnf")
            let scramble = index < session.scrambles.count ? session.scrambles[index] : ""
            
            let solveData: [String: Any] = [
                "index": index + 1,
                "time": solve.getMyString(),
                "penalty": penalty,
                "scramble": scramble
            ]
            
            solves.append(solveData)
        }
        
        jsonData["solves"] = solves
        
        do {
            let jsonDataFormatted = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            return String(data: jsonDataFormatted, encoding: .utf8) ?? ""
        } catch {
            return "{\"error\": \"Failed to serialize JSON\"}"
        }
    }
    
    private static func exportToText(_ session: Session) -> String {
        var text = "Cubing Session: \(session.name)\n"
        text += "Event: \(eventName(for: session.scrambler.myEvent))\n"
        text += "Export Date: \(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))\n"
        text += "Total Solves: \(session.times.count)\n\n"
        
        if session.times.count > 0 {
            let best = session.getBest()
            text += "Best Time: \(best != "" ? best : "N/A")\n"
            
            // Add averages if available
            if session.times.count >= 5 {
                text += "Average of 5: \(session.getCurrentAverage(5))\n"
            }
            if session.times.count >= 12 {
                text += "Average of 12: \(session.getCurrentAverage(12))\n"
            }
            
            text += "\nSolve Times:\n"
            text += "------------\n"
            
            for (index, solve) in session.times.enumerated() {
                let penalty = solve.penalty == 0 ? "" : (solve.penalty == 1 ? " (+2)" : " (DNF)")
                text += "\(index + 1). \(solve.getMyString())\(penalty)\n"
            }
        }
        
        return text
    }
    
    private static func fileExtension(for format: ExportFormat) -> String {
        switch format {
        case .csv: return "csv"
        case .json: return "json"
        case .text: return "txt"
        }
    }
    
    private static func eventName(for eventNumber: Int) -> String {
        // Map event numbers to names - simplified
        switch eventNumber {
        case 1: return "3x3x3"
        case 2: return "2x2x2"
        case 3: return "4x4x4"
        case 4: return "5x5x5"
        default: return "Unknown"
        }
    }
    
    private static func showErrorAlert(in viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Export Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
}