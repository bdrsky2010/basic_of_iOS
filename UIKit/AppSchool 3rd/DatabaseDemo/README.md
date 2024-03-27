# SQLite 를 이용한 iOS 데이터베이스

SQLite란?

> SQLite는 내장된 관계형 데이터베이스 관리 시스템(RDBMS)
- 대부분의 관계형 데이터베이스(예: Oracle 및 MySQL)는 독립적으로 실행되고 데이터베이스 액세스가 필요한 앱과 협력하는 독립형 서버 프로세스
- SQLite는 앱과 연동되는 라이브러리로 제공되기 때문에 임베디드라고 함
- 따라서 백그라운드에서 실행되는 독립형 데이터베이스 서버가 없고, 대신 모든 데이터베이스 작업은 SQLite 라이브러리에 포함된 함수 호출을 통해 앱 내에서 내부적으로 처리

SQLite는 C 프로그래밍 언어로 작성
- Swift 코드 내에서 SQLite를 사용하려면 C 함수 호출, 데이터 유형 및 포인터의 복잡한 처리가 필요하거나
- 기존 SQLite 래퍼를 SQLite와 Swift 사이의 계층으로 사용하는 보다 간단한 접근 방식이 필요
  - 래퍼 중 하나인 [FMDB](https://github.com/ccgus/fmdb.git) 를 이용

SQLite에 대한 자세한 내용은 https://www.sqlite.org 를 참조

#### 데이터베이스

구조적 특징 (방향성)
- 통합성 : 동일 데이터가 중복되지 않음
- 저장성 : 저장 매체에 저장
- 공용성 : 여러 사용자가 다양한 목적으로 사용할 수 있음
- 변화성 : 새로은 데이터 삽입과 기존 데이터 삭제 및 변경이 가능

(CRUD)

구조적 쿼리 언어(SQL, Structured Query Language)

- 데이터는 구조적 쿼리 언어(Structured Query Language)로 알려진 고급 언어를 사용하여 SQLite 데이터베이스에 액세스
- SQL은 대부분의 관계형 데이터베이스 관리 시스템에서 사용되는 표준 언어
- SQLite는 주로 SQL-92 표준을 따름

SQL 3가지 용도
- DDL : 데이터 베이스 정의 (이해를 위한 예시, 프로젝트 생성, 변경, 삭제)
- DML : 데이터 조작, 데이터를 불러오고 처리(CRUD)
- DCL : 데이터 제어, 데이터 보완, 무경성, 병행 처리 제어 명령어

macOS 에서 SQLite 사용해 보기

- 내장된 SQLite 관계형 데이터베이스 관리 시스템

```swift
# 대화형 SQLite 세션을 시작하려면 macOS 시스템에서 터미널 창을 열고
# 디렉터리를 적절한 위치로 변경한 후 다음 명령을 실행
sqlite3 ./mydatabase.db
SQLite version 3.39.5 2022-10-14 20:58:05
Enter ".help" for usage hints.
Enter SQL statements terminated with a ";"
sqlite>

# sqlite> 프롬프트에서는 테이블 생성, 데이터 삽입 및 검색과 같은 작업을 수행하기 위한
# 명령을 입력할 수 있습니다. 예를 들어, ID, 이름, 주소 및 전화번호 필드를 포함하는
# 필드가 있는 데이터베이스에 새 테이블을 생성하려면 다음 명령문이 필요
create table contacts (id integer primary key autoincrement, name text, address
text, phone text);

# 테이블의 각 행에는 해당 행에 고유한 기본 키가 있어야 합니다.
# 위의 예에서는 ID 필드를 기본 키로 지정하고 이를 정수 유형으로 선언했으며 행이
# 자동으로 추가될 때마다 SQLite에 숫자를 증가시키도록 요청했습니다.
# 이는 각 행에 고유한 기본 키가 있는지 확인하는 일반적인 방법입니다.
# 나머지 필드는 각각 텍스트 유형으로 선언됩니다.

# 현재 선택한 데이터베이스의 테이블을 나열하려면 .tables 문을 사용하세요
sqlite> .tables
contacts

# 테이블에 레코드를 삽입하려면:
sqlite> insert into contacts (name, address, phone) values ("Bill Smith", "123
Main Street, California", "123-555-2323");
sqlite> insert into contacts (name, address, phone) values ("Mike Parks", "10
Upping Street, Idaho", "444-444-1212");

# 테이블에서 모든 행을 검색하려면
sqlite> select * from contacts;
1|Bill Smith|123 Main Street, California|123-555-2323
2|Mike Parks|10 Upping Street, Idaho|444-444-1212

# 특정 기준을 충족하는 행을 추출하려면
sqlite> select * from contacts where name="Mike Parks";
2|Mike Parks|10 Upping Street, Idaho|444-444-1212

# sqlite3 대화형 환경을 종료하려면
sqlite> .exit
```

```swift
# 테이블 만들기
create table 테이블이름 (
    컬럼이름 타입(INT|TEXT),
    컬럼이름 타입(INT|TEXT),
    ....
);

# 테이블 삭제
drop table 테이블이름;
```

```swift
# 데이터 추가(삽입)
insert into 테이블이름 (컬럼명, ....) values (1, "aaa", "bbb");

# 데이터 검색(가져오기)
select 컬럼명 from 테이블이름
```

#### SQLite 기반의 iOS 앱 예시

- FMDB 클래스 참조 문서
- http://ccgus.github.io/fmdb/html/Classes/FMDatabase.html

앱 개요

> SQlite DB에 연락처 정보(이름, 주소, 전화번호)를 저장하는 간단한 앱
- 데이터 저장과 검색

- 목표 : Core Data Framework 를 사용하면 쉬우나 여기에서는 Object-C로 제공되는 라이브러리를 포함하는 것을 경험

libsqlite3.tbd 라이브러리를 프로젝트에 추가

데이터베이스 초기화

- 앱의 Documents 디렉터리를 식별하여 contacts.db 파일에 대한 경로를 구성
- 데이터베이스 파일이 이미 존재하는지 확인

SQLite 데이터베이스에 데이터를 저장
- 데이베이스 파일을 열고
- 텍스트 필드에 있는 텍스트를 가지고 쿼리문을 작성
- SQL insert 문을 구성해서 데이터베이스 레코드(행)로 추가
- 작업 수행 후 데이터베이스를 닫음

SQLite 데이터베이스 데이터를 검색(추출)
- 사용자의 이름을 입려갛고 찾기 버튼을 클릭(터치)하여 연락처 주소와 전화번호를 가져옴

검색결과가 목록으로 전달될 경우

```swift
    @IBAction func findContact(_ sender: Any) {
        let contactDB = FMDatabase(path: databasePath)
        var items = [Contact]()
        
        if contactDB.open() {
            let sql = "select name, address, phone from contacts where name='\(name.text ?? "")'"
            
            do {
                let results: FMResultSet? = try contactDB.executeQuery(sql, values: nil)
                
                while results?.next() == true {
                    let name = results?.string(forColumn: "name")
                    let address = results?.string(forColumn: "address")
                    let phone = results?.string(forColumn:
                    items.append(Contact(name: name, address: address, phone: phone))
                }
                
            } catch {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            
            contactDB.close()
            
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        for i in items {
            print("\(i.address ?? ""), \(i.phone ?? "")" )
        }
    }
```

확장

```swift
//
//  ViewController.swift
//  DatabaseDemo
//

import UIKit

class ViewController: UIViewController {
    
//...
    
    @IBAction func findContact(_ sender: Any) {
        let contactDB = FMDatabase(path: databasePath)
        var items = [Contact]()
        
        if contactDB.open() {
            let sql = "select name, address, phone from contacts where name='\(name.text ?? "")'"
            
            do {
                let results: FMResultSet? = try contactDB.executeQuery(sql, values: nil)
                
                while results?.next() == true {
                    let name = results?.string(forColumn: "name")
                    let address = results?.string(forColumn: "address")
                    let phone = results?.string(forColumn: "phone")

                    items.append(Contact(name: name, address: address, phone: phone))
                }
                
            } catch {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            
            contactDB.close()
            
        } else {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        for i in items {
            print("\(i.address ?? ""), \(i.phone ?? "")" )
        }
    }
    
}

struct Contact {
    let name: String?
    let address: String?
    let phone: String?
}

```
