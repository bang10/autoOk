//
//  AttendanceService.swift
//  autoCheck
//
//  Created by seonghwan on 10/3/23.
//

import Foundation
import Alamofire

struct AttendanceBeacon {
    var connectionBeacon = ConnectBeacon()
    var attendanceService = AttendanceService()
    
    func detectBeacon(ssAaDto: SSAADto, result: @escaping(Bool?) -> Void) {
        if connectionBeacon.beaconDetected {
            if ssAaDto.isAttendance == "" {
                attendanceService.saveAttendance(param: ssAaDto) { res, error in
                    if let res = res {
                        result(true)
                    }
                }
            }
        }
    }
}

class AttendanceService {
    private var baseUrl = API_SET()
    
    func getTodayStudnetAttendaceInfo(studentId: String) async throws -> TodayStudentAttendanceInfoDto {
        let url = URL(string: baseUrl.getBaseUrl() + "/ysu/attendance/today/\(studentId)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let decoderResult = try decoder.decode(TodayStudentAttendanceInfoDto.self, from: data)
            return decoderResult
        } catch {
            throw error
        }
    }

    
    func getAttendanceInfo(result: @escaping([AttendanceInfoDto]?, Error?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/attendance/list", method: .get).responseData { response in
            switch response.result {
            case.success(let value):
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode([AttendanceInfoDto].self, from: value as! Data)
                    result(res, nil)
                } catch {
                    result(nil, error)
                }
            case.failure(let error):
                result(nil, error)
            }
        }
    }
    
    func saveAttendance(param: SSAADto, result: @escaping(SubjectAttendance?, Error?) -> Void) {
        AF.request(baseUrl.getBaseUrl() + "/ysu/attendance/save", method: .post, parameters: param, encoder: JSONParameterEncoder.default).responseJSON { res in
            if res.response?.statusCode == 200 {
                switch res.result {
                case.success(let value):
                    do {
                        let decoder = JSONDecoder()
                        let data = try JSONSerialization.data(withJSONObject: value)
                        let res = try decoder.decode(SubjectAttendance.self, from: data)
                        result(res, nil)
                    } catch {
                        result(nil, error)
                    }
                case.failure(let error):
                    result(nil, error)
                }
            }
        }
    }
    
    func attendance() {
        
    }
}
