//
//  Storage.swift
//
//  Created by 이중엽 on 2022/08/18.
//

import Foundation

public class Storage {
    
    private init() { }
    
    enum Directory {
        case documents
        case caches
        
        //https://yeongwoo-cho.tistory.com/112
        var url: URL {
            let path: FileManager.SearchPathDirectory
            switch self {
            case .documents:
                path = .documentDirectory
            case .caches:
                path = .cachesDirectory
            }
            return FileManager.default.urls(for: path, in: .userDomainMask).first!
        }
    }
    
    //todos를 json 형태로 바꾸어서 저장 (경로는 Documents directory)
    static func store<T: Encodable>(_ obj: T, to directory: Directory, as fileName: String) {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> save to here: \(url)")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            //obj -> todos
            //todos를 Json encoder를 통해 json 형태로 바꾸어 data 변수에 저장
            let data = try encoder.encode(obj)
            
            //FileManager를 통해 해당 url 경로에 파일이 존재하면 삭제
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            //FileManager를 통해 해당 url 경로에 파일 (json - data)를 저장
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let error {
            print("--> Failed to store msg: \(error.localizedDescription)")
        }
    }
    
    //json 형태로 저장된 데이터를 다시 todos로 전환
    static func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        //todos.json 파일 경로
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        
        //경로 내에 todos.json 파일이 없으면 함수 종료
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        
        //todos.json 파일 데이터를 data 변수에 저장
        guard let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        //decoder 객체 생성
        let decoder = JSONDecoder()
        
        //decoder를 통해 todos.json을 원래 todos로 변환하여 반환 그 외 에러 처리
        do {
            let model = try decoder.decode(type, from: data)
            return model
        } catch let error {
            print("---> Failed to decode msg: \(error.localizedDescription)")
            return nil
        }
    }
    
    //경로에 위치한 파일 삭제
    static func remove(_ fileName: String, from directory: Directory) {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch let error {
            print("---> Failed to remove msg: \(error.localizedDescription)")
        }
    }
    
    static func clear(_ directory: Directory) {
        let url = directory.url
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for content in contents {
                try FileManager.default.removeItem(at: content)
            }
        } catch {
            print("---> Failed to clear directory msg: \(error.localizedDescription)")
        }
    }
}

//todo 객체만을 위한 저장 함수
extension Storage {
    static func saveTodo(_ obj: Todo, fileName: String) {
        let url = Directory.documents.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> [TEST] save to here: \(url)")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
         
        do {
            let data = try encoder.encode(obj)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let error {
            print("---> Failed to store msg: \(error.localizedDescription)")
        }
    }

    
    
    static func restoreTodo(_ fileName: String) -> Todo? {
        let url = Directory.documents.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        guard let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(Todo.self, from: data)
            return model
        } catch let error {
            print("---> Failed to decode msg: \(error.localizedDescription)")
            return nil
        }
    }
}
