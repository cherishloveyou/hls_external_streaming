//
//  ServerConnector.swift
//  Pods
//
//  Created by yugo horie on 2017/06/21.
//
//

import Foundation
class ServerConnector{
    
    private var server_addr:String
    private var tsdata:Data = Data()
    
    init(address:String){
        self.server_addr = address
        self.tsdata = Data()
    }
    
    open func setAddress(address:String){
        self.server_addr = address
    }
    open func appendTSdata(data:[UInt8],count:Int){
        //print("append size:\(count)")
        self.tsdata += Data(bytes: UnsafePointer<UInt8>(data),count: data.count)
    }
    
    open func getTSdata() -> NSData{
        return self.tsdata as NSData
    }
    open func sendFiles(tsData:NSData,filename:String){
        let url = NSURL(string: self.server_addr)
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest()
        if let u = url{
            urlRequest.url = u as URL
            urlRequest.httpMethod = "POST"
            urlRequest.timeoutInterval = 30.0
        }
        let uniqueId = ProcessInfo.processInfo.globallyUniqueString
        let body: NSMutableData = NSMutableData()
        var postData :String = String()
        let boundary:String = "---------------------------\(uniqueId)"
        
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type") //(1)
        
        postData += "--\(boundary)\r\n"
        
        if(filename == "playlist.m3u8"){
            postData += "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n" //(2)
            postData += "Content-Type: application/x-mpegURL\r\n\r\n"
        }else{
            postData += "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n" //(2)
            postData += "Content-Type: video/mp2t\r\n\r\n"
        }
        
        body.append(postData.data(using: String.Encoding.utf8)!)
        body.append(tsData as Data)
        
        postData = String()
        postData += "\r\n"
        postData += "\r\n--\(boundary)--\r\n"
        
        body.append(postData.data(using: String.Encoding.utf8)!) //(3)
        
        urlRequest.httpBody = NSData(data:body as Data) as Data
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        print(filename)
        print("send size:\(tsData.length)")
        let task: URLSessionDataTask = session.dataTask(with: urlRequest as URLRequest, completionHandler: { data, request, error in
          //self.tsdata = Data()
        })
        task.resume()
    }
}
