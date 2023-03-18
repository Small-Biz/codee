//
//  Manager.swift
//  TaxiMockExam
//
//  Created by Ray on 13/1/2020.
//  Copyright © 2020 HeeSolutionsLimited. All rights reserved.
//

import UIKit
import StorageManager

class Manager: NSObject {

    static let shared = Manager()
    
    static var currUserIndex:Int = 0
    static var currUser:User!
    static var currLevel:Int=0
    static var currTask:Task?
    static var targetBadge:Int = 0
    static var multipleFactorFrom:Int = 2
    static var multipleFactorTo:Int = 2
    
    static var badgeList: [Int] = [Int]()
    static var userList: [User] = [User]()
    
    struct DefaultsKeys {
        static let badgeList = "badgeList"
        static let userList = "userList"
    }
    
    override
    private init() {
        print("Manager initialized")
    }
   
    static func storeCurrUserBadgetList(){
        if ( currUser == nil ){
            return
        }
        print("badgeList: ",  badgeList) // Some String Value
        let key:String = String(format: "%@_%@", DefaultsKeys.badgeList, currUser.name)
        print("storeCurrUserBadgetList key: ", key)
        try! StorageManager.default.store(array: badgeList, in: key)
    }
    
    static func reloadCurrUserBadgetList(){
        let key:String = String(format: "%@_%@", DefaultsKeys.badgeList, currUser.name)
        print("reloadCurrUserBadgeList key: ", key)
        do{
            badgeList = try StorageManager.default.arrayValue(key)
        } catch let error {
            print(error.localizedDescription)
            badgeList = [Int]()
        }
        print("badgeList: ",  badgeList) // Some String Value
    }
    
    static func storeData(){

//        try! StorageManager.default.store(array: badgeList, in: DefaultsKeys.badgeList)
//        try! StorageManager.default.update(vlaue: newX, forKey: "x", in: "exampleDictionary")
        try! StorageManager.default.store(array: userList, in: DefaultsKeys.userList)
    }
    
    static func reloadData(){
//        do{
//            badgeList = try StorageManager.default.arrayValue(DefaultsKeys.badgeList)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        badgeList = getDummyBadgeList()

        do{
            userList = try StorageManager.default.arrayValue(DefaultsKeys.userList)
        } catch let error {
            print(error.localizedDescription)
        }
        
        userList=getDummyUserList()
        
        if ( userList.count > 0 ){
            currUser = userList[currUserIndex]
        }
        
        print("userList: ",  userList) // Some String Value
        if ( currUser != nil ){
            print("currUser: ",  currUser.name as Any) // Some String Value
        }
    }
    
    static func getDummyBadgeList() -> Array<Int> {
        var resultBadgeList = [Int]()
                
        for i in 0...TaskManager.shared.getFullTaskList().count-1{
            resultBadgeList.append( i%6);
        }
        
        return resultBadgeList;
    }
    
    static func getDummyUserList() -> Array<User> {
        var resultUserList = [User]()
                

        resultUserList.append( User(name: "Keira", gender: 0));
        resultUserList.append( User(name: "Lyra", gender: 0));
        
        return resultUserList;
    }
    
    func questionFullList() -> Array<Array<String>> {
        
        var questionList = [[String]]()
        
        questionList.append( ["威爾斯親王醫院","沙田",""]);
        questionList.append( ["贊育醫院","西營盤",""]);
        questionList.append( ["東華醫院","上環",""]);
        questionList.append( ["東華三院馮堯敬醫院","薄扶林",""]);
        questionList.append( ["葛量洪醫院","黃竹坑",""]);
        questionList.append( ["東區尤德夫人那打素醫院","柴灣",""]);
        questionList.append( ["東華東院","大坑",""]);
        questionList.append( ["鄧肇堅醫院","灣仔",""]);
        questionList.append( ["律敦治醫院","灣仔",""]);
        questionList.append( ["黃竹坑醫院","黃竹坑徑","S"]);
        questionList.append( ["伊利沙伯醫院","油麻地",""]);
        questionList.append( ["九龍醫院","九龍城",""]);
        questionList.append( ["香港佛教醫院","樂富",""]);
        questionList.append( ["香港眼科醫院","九龍城",""]);
        questionList.append( ["東華三院黃大仙醫院","沙田坳道","S"]);
        questionList.append( ["聖母醫院","黃大仙",""]);
        questionList.append( ["廣華醫院","油麻地",""]);
        questionList.append( ["明愛醫院","長沙灣",""]);
        questionList.append( ["瑪嘉烈醫院","荔景",""]);
        questionList.append( ["葵涌醫院","荔景",""]);
        questionList.append( ["仁濟醫院","荃灣",""]);
        questionList.append( ["基督教聯合醫院","秀茂坪","S"]);
        questionList.append( ["靈實醫院","將軍澳",""]);
        questionList.append( ["將軍澳醫院","寶寧里","S"]);
        questionList.append( ["沙田醫院","亞公角街","S"]);
        questionList.append( ["雅麗氏何妙齡那打素醫院","大埔",""]);
        questionList.append( ["大埔醫院","全安路","S"]);
        questionList.append( ["北區醫院","上水","S"]);
        questionList.append( ["屯門醫院","青松觀路","S"]);
        questionList.append( ["博愛醫院","元朗",""]);
        questionList.append( ["嘉諾撒醫院","半山",""]);
        questionList.append( ["明德國際醫院","山頂",""]);
        questionList.append( ["香港港安醫院","跑馬地",""]);
        questionList.append( ["聖保祿醫院","東院道","S"]);
        questionList.append( ["養和醫院","跑馬地",""]);
        questionList.append( ["寶血醫院(明愛)","深水埗",""]);
        questionList.append( ["播道醫院","九龍城",""]);
        questionList.append( ["聖德肋撒醫院","九龍城",""]);
        questionList.append( ["香港浸信會醫院","九龍塘",""]);
        questionList.append( ["荃灣港安醫院","荃景圍","S"]);
        questionList.append( ["沙田國際醫務中心仁安醫院","富健街","S"]);
        questionList.append( ["青山醫院","屯門",""]);
        questionList.append( ["小欖醫院","青松觀路","S"]);
        questionList.append( ["大口環根德公爵夫人兒童醫院","薄扶林",""]);
        questionList.append( ["北大嶼山醫院","松仁路","S"]);
        questionList.append( ["天水圍醫院","天壇街","S"]);
        questionList.append( ["港怡醫院","黃竹坑",""]);
        questionList.append( ["星光大道","尖沙咀",""]);
        questionList.append( ["廖萬石堂","上水","S"]);
        questionList.append( ["金紫荊廣場","灣仔",""]);
        questionList.append( ["香港迪士尼樂園","竹篙灣","S"]);
        questionList.append( ["香港濕地公園","天水圍",""]);
        questionList.append( ["玉器市場","油麻地",""]);
        questionList.append( ["九龍寨城公園","九龍城",""]);
        questionList.append( ["昂坪纜車 - 東涌纜車站","達東路","S"]);
        questionList.append( ["香港海洋公園","黃竹坑",""]);
        questionList.append( ["寶蓮禪寺","昂坪",""]);
        questionList.append( ["凌霄閣","山頂道","S"]);
        questionList.append( ["亞洲國際博覽館","赤鱲角",""]);
        questionList.append( ["吉慶圍","錦田",""]);
        questionList.append( ["屏山文物徑","元朗",""]);
        questionList.append( ["匯星","九龍灣",""]);
        questionList.append( ["香港會議展覽中心","灣仔",""]);
        questionList.append( ["香港文化博物館","沙田",""]);
        questionList.append( ["香港歷史博物館","尖沙咀",""]);
        questionList.append( ["香港科學館","尖沙咀",""]);
        questionList.append( ["香港太空館","尖沙咀",""]);
        questionList.append( ["香港大會堂","中環",""]);
        questionList.append( ["香港體育館","紅磡",""]);
        questionList.append( ["香港文化中心","尖沙咀",""]);
        questionList.append( ["伊利沙伯體育館","灣仔",""]);
        questionList.append( ["沙田大會堂","源禾路","S"]);
        questionList.append( ["新光戲院大劇場","北角",""]);
        questionList.append( ["大夫第","新田",""]);
        questionList.append( ["尖沙咀天星碼頭","尖沙咀",""]);
        questionList.append( ["1881","廣東道","S"]);
        questionList.append( ["沙田車公廟","大圍",""]);
        questionList.append( ["文武廟","上環",""]);
        questionList.append( ["林村許願廣場","大埔",""]);
        questionList.append( ["龍躍頭文物徑","粉嶺",""]);
        questionList.append( ["美利樓","赤柱","S"]);
        questionList.append( ["和昌大押","莊士敦道","S"]);
        questionList.append( ["大館","荷李活道","S"]);
        questionList.append( ["香港藝術館","尖沙咀",""]);
        questionList.append( ["8度海逸酒店","土瓜灣",""]);
        questionList.append( ["九龍海逸君綽酒店","紅磡",""]);
        questionList.append( ["九龍維景酒店","何文田",""]);
        questionList.append( ["九龍酒店","尖沙咀",""]);
        questionList.append( ["九龍香格里拉大酒店","尖沙咀",""]);
        questionList.append( ["六國酒店","灣仔",""]);
        questionList.append( ["北角海逸酒店","英皇道","S"]);
        questionList.append( ["千禧新世界香港酒店","尖沙咀",""]);
        questionList.append( ["君怡酒店","尖沙咀",""]);
        questionList.append( ["嘉湖海逸酒店","天水圍",""]);
        questionList.append( ["城市花園酒店","北角",""]);
        questionList.append( ["富豪九龍酒店","尖沙咀",""]);
        questionList.append( ["富豪東方酒店","九龍城",""]);
        questionList.append( ["富豪香港酒店","銅鑼灣",""]);
        questionList.append( ["帝京酒店","旺角",""]);
        questionList.append( ["帝景酒店","汀九",""]);
        questionList.append( ["帝樂文娜公館","尖沙咀",""]);
        questionList.append( ["帝苑酒店","尖沙咀",""]);
        questionList.append( ["帝都酒店","沙田",""]);
        questionList.append( ["柏寧酒店","銅鑼灣",""]);
        questionList.append( ["港島英迪格酒店","灣仔",""]);
        questionList.append( ["皇家太平洋酒店","尖沙咀",""]);
        questionList.append( ["諾富特東薈城酒店","東涌",""]);
        questionList.append( ["都會海逸酒店","紅磡",""]);
        questionList.append( ["香港半島酒店","尖沙咀",""]);
        questionList.append( ["香港君悅酒店","灣仔",""]);
        questionList.append( ["香港喜來登酒店","尖沙咀",""]);
        questionList.append( ["香港四季酒店","中環",""]);
        questionList.append( ["香港天際萬豪酒店","赤鱲角",""]);
        questionList.append( ["香港康得思酒店","上海街","S"]);
        questionList.append( ["香港文華東方酒店","中環",""]);
        questionList.append( ["香港朗廷酒店","尖沙咀",""]);
        questionList.append( ["香港沙田凱悅酒店","澤祥街","S"]);
        questionList.append( ["香港洲際酒店","尖沙咀",""]);
        questionList.append( ["香港港麗酒店","金鐘",""]);
        questionList.append( ["香港灣仔帝盛酒店","皇后大道東","S"]);
        questionList.append( ["香港珀麗酒店","銅鑼灣",""]);
        questionList.append( ["香港百樂酒店","尖沙咀",""]);
        questionList.append( ["香港置地文華東方酒店","皇后大道中","S"]);
        questionList.append( ["香港芬名酒店","灣仔",""]);
        questionList.append( ["香港華美粵海酒店","灣仔",""]);
        questionList.append( ["香港萬麗海景酒店","灣仔",""]);
        questionList.append( ["香港諾富特世紀酒店","灣仔",""]);
        questionList.append( ["香港金域假日酒店","尖沙咀",""]);
        questionList.append( ["香港銅鑼灣皇冠假日酒店","禮頓道","S"]);
        questionList.append( ["香港麗悅酒店","灣仔",""]);
        questionList.append( ["香港黃金海岸酒店","掃管笏","S"]);
        questionList.append( ["馬哥孛羅香港酒店","尖沙咀",""]);
        questionList.append( ["麗景酒店","尖沙咀",""]);
        questionList.append( ["麗豪酒店","沙田",""]);
        questionList.append( ["麗駿酒店","灣仔",""]);
        questionList.append( ["逸蘭精品酒店","銅鑼灣",""]);
        questionList.append( ["香港維港凱悅尚萃","北角",""]);
        questionList.append( ["麥當勞道貳號","半山",""]);
        questionList.append( ["中環•石板街酒店","皇后大道中","S"]);
        questionList.append( ["九龍珀麗酒店","大角咀",""]);
        questionList.append( ["唯港薈","尖沙咀",""]);
        questionList.append( ["問月酒店","銅鑼灣",""]);
        questionList.append( ["壹96酒店","皇后大道中","S"]);
        questionList.append( ["大澳文物酒店","石仔埗","S"]);
        questionList.append( ["太子酒店","尖沙咀",""]);
        questionList.append( ["奕居","金鐘",""]);
        questionList.append( ["奧華酒店-南岸","黃竹坑",""]);
        questionList.append( ["如心南灣海景酒店","香港仔",""]);
        questionList.append( ["如心海景酒店暨會議中心","荃灣",""]);
        questionList.append( ["如心艾朗酒店","觀塘",""]);
        questionList.append( ["如心銅鑼灣海景酒店","英皇道","S"]);
        questionList.append( ["富薈上環酒店","文咸東街","S"]);
        questionList.append( ["富薈灣仔酒店","莊士敦道","S"]);
        questionList.append( ["富薈炮台山酒店","北角",""]);
        questionList.append( ["富豪機場酒店","赤鱲角",""]);
        questionList.append( ["尖沙咀皇悅酒店","金巴利道","S"]);
        questionList.append( ["帆船精品酒店","摩理臣山道","S"]);
        questionList.append( ["恆豐酒店","尖沙咀",""]);
        questionList.append( ["數碼港艾美酒店","數碼港道","S"]);
        questionList.append( ["晉逸精品酒店中環","威靈頓街","S"]);
        questionList.append( ["晉逸精品酒店尖沙咀","寶勒巷","S"]);
        questionList.append( ["晉逸蘭桂坊精品酒店中環","德己立街","S"]);
        questionList.append( ["木的地酒店","佐敦",""]);
        questionList.append( ["木的地酒店-中環","荷里活道","S"]);
        questionList.append( ["海景嘉福洲際酒店","尖沙咀",""]);
        questionList.append( ["港威酒店","尖沙咀",""]);
        questionList.append( ["港島海逸君綽酒店","北角",""]);
        questionList.append( ["港島皇悅酒店","軒尼詩道","S"]);
        questionList.append( ["港島香格里拉大酒店","法院道","S"]);
        questionList.append( ["港景匯","柯士甸道西","S"]);
        questionList.append( ["登臺酒店","佐敦",""]);
        questionList.append( ["紫珀酒店","尖沙咀",""]);
        questionList.append( ["美麗華酒店","尖沙咀",""]);
        questionList.append( ["華美達海景酒店","皇后大道西","S"]);
        questionList.append( ["華麗都會酒店","皇后大道西","S"]);
        questionList.append( ["蘭桂坊酒店@九如坊","中環",""]);
        questionList.append( ["迪士尼好萊塢酒店","大嶼山",""]);
        questionList.append( ["迪士尼探索家度假酒店","竹篙灣","S"]);
        questionList.append( ["銅鑼灣皇悅酒店","永興街","S"]);
        questionList.append( ["香港今旅","西環",""]);
        questionList.append( ["香港W酒店","柯士甸道西","S"]);
        questionList.append( ["香港JW萬豪酒店","金鐘道","S"]);
        questionList.append( ["香港九龍東皇冠假日酒店","將軍澳",""]);
        questionList.append( ["香港九龍諾富特酒店","油麻地",""]);
        questionList.append( ["香港九龍貝爾特酒店","新蒲崗",""]);
        questionList.append( ["香港君臨海域酒店","銅鑼灣",""]);
        questionList.append( ["香港嘉里酒店","紅磡",""]);
        questionList.append( ["香港寶御酒店","尖沙咀",""]);
        questionList.append( ["香港尖沙咀凱悦酒店","河內道","S"]);
        questionList.append( ["香港屯門貝爾特酒店","震寰路","S"]);
        questionList.append( ["香港旺角帝盛酒店","大角咀",""]);
        questionList.append( ["香港旺角薈賢居","廣東道","S"]);
        questionList.append( ["香港東隅","鰂魚涌",""]);
        questionList.append( ["香港極棧酒店","尖沙咀",""]);
        questionList.append( ["香港沙田萬怡酒店","安平街","S"]);
        questionList.append( ["香港灣仔睿景酒店","軒尼詩道","S"]);
        questionList.append( ["香港珀麗尚品酒店","銅鑼灣",""]);
        questionList.append( ["香港瑰麗酒店","尖沙咀",""]);
        questionList.append( ["香港盛捷維園公寓酒店","北角",""]);
        questionList.append( ["香港美利酒店","中環",""]);
        questionList.append( ["香港荃灣帝盛酒店","葵涌",""]);
        questionList.append( ["香港荃灣絲麗酒店","葵涌",""]);
        questionList.append( ["香港萬怡酒店","干諾道西","S"]);
        questionList.append( ["香港觀塘帝盛酒店","鴻圖道","S"]);
        questionList.append( ["香港迪士尼樂園酒店","竹篙灣","S"]);
        questionList.append( ["香港逸東酒店","佐敦",""]);
        questionList.append( ["香港遨凱酒店","大角咀",""]);
        questionList.append( ["香港銅鑼灣維景酒店","銅鑼灣道","S"]);
        questionList.append( ["香港麗思卡爾頓酒店","柯士甸道西","S"]);
        questionList.append( ["北角政府合署","渣華道","S"]);
        questionList.append( ["長沙灣政府合署","長沙灣道","S"]);
        questionList.append( ["何文田政府合署","忠孝街","S"]);
        questionList.append( ["東九龍政府合署","觀塘",""]);
        questionList.append( ["九龍政府合署","油麻地",""]);
        questionList.append( ["葵興政府合署","興芳路","S"]);
        questionList.append( ["荔枝角政府合署","荔灣道","S"]);
        questionList.append( ["馬頭角道政府合署","馬頭角道","S"]);
        questionList.append( ["旺角政府合署","聯運街","S"]);
        questionList.append( ["梅窩政府合署","銀鑛灣路","S"]);
        questionList.append( ["牛頭角政府合署","安華街","S"]);
        questionList.append( ["北區政府合署","粉嶺",""]);
        questionList.append( ["培正道政府合署","何文田",""]);
        questionList.append( ["西貢政府合署","親民街","S"]);
        questionList.append( ["沙田政府合署","上禾輋路","S"]);
        questionList.append( ["深水埗政府合署","元州街","S"]);
        questionList.append( ["大興政府合署","屯門",""]);
        questionList.append( ["大埔政府合署","汀角路","S"]);
        questionList.append( ["土瓜灣政府合署","馬頭圍道","S"]);
        questionList.append( ["荃灣政府合署","西樓角路","S"]);
        questionList.append( ["屯門政府合署","屯喜路","S"]);
        questionList.append( ["元朗政府合署","橋樂坊","S"]);
        questionList.append( ["觀塘區警署","鯉魚門道","S"]);
        questionList.append( ["旺角區警署","太子道西","S"]);
        questionList.append( ["將軍澳區警署","寶琳北路","S"]);
        questionList.append( ["荃灣區警署","荃景圍","S"]);
        questionList.append( ["中區警區總部","中港道","S"]);
        questionList.append( ["東區法院大樓","西灣河",""]);
        questionList.append( ["終審法院","中環",""]);
        questionList.append( ["立法會綜合大樓","金鐘",""]);
        questionList.append( ["香港禮賓府","中環",""]);
        questionList.append( ["香港中央圖書館","銅鑼灣",""]);
        questionList.append( ["醫院管理局大樓","九龍城",""]);
        questionList.append( ["九龍城法院大樓","亞皆老街","S"]);
        questionList.append( ["觀塘法院大樓","鯉魚門道","S"]);
        questionList.append( ["粉嶺法院大樓","璧峰路","S"]);
        questionList.append( ["沙田法院大樓","宜正里","S"]);
        questionList.append( ["屯門法院大樓","屯喜路","S"]);
        questionList.append( ["西九龍法院大樓","通州街","S"]);
        questionList.append( ["高等法院","金鐘道","S"]);
        questionList.append( ["勞資審裁處","加士居道","S"]);
        questionList.append( ["土地審裁處","加士居道","S"]);
        questionList.append( ["區域法院","港灣道","S"]);
        questionList.append( ["中環中心","皇后大道中","S"]);
        questionList.append( ["如心廣場","荃灣",""]);
        questionList.append( ["長江集團中心","中環",""]);
        questionList.append( ["利園","銅鑼灣",""]);
        questionList.append( ["新鴻基中心","灣仔",""]);
        questionList.append( ["華懋交易廣場","鰂魚涌",""]);
        questionList.append( ["周大福商業中心","旺角",""]);
        questionList.append( ["中國海外大廈","灣仔",""]);
        questionList.append( ["力寶中心","金鐘",""]);
        questionList.append( ["卡佛大廈","中環",""]);
        questionList.append( ["美麗華大廈","尖沙咀",""]);
        questionList.append( ["太古廣場","金鐘",""]);
        questionList.append( ["英國保誠保險大樓","尖沙咀",""]);
        questionList.append( ["中國太平大廈","新寧道","S"]);
        questionList.append( ["電視廣播有限公司電視廣播城","將軍澳",""]);
        questionList.append( ["港威大廈","尖沙咀",""]);
        questionList.append( ["貿易廣場","長沙灣",""]);
        questionList.append( ["有線電視大樓","荃灣",""]);
        questionList.append( ["海富中心","夏慤道","S"]);
        questionList.append( ["統一中心","金鐘",""]);
        questionList.append( ["港景匯商場","尖沙咀",""]);
        questionList.append( ["環球大廈","中環",""]);
        questionList.append( ["國際金融中心","中環",""]);
        questionList.append( ["環球貿易廣場","柯士甸道西","S"]);
        questionList.append( ["中環廣場","港灣道","S"]);
        questionList.append( ["中銀大廈","花園道","S"]);
        questionList.append( ["港島東中心","鰂魚涌",""]);
        questionList.append( ["中遠大廈","皇后大道中","S"]);
        questionList.append( ["花園道三號","中環",""]);
        questionList.append( ["中國網絡中心","駱克道","S"]);
        questionList.append( ["怡和大廈","中環",""]);
        questionList.append( ["永安集團大廈","德輔道中","S"]);
        questionList.append( ["盈置大廈","干諾道中","S"]);
        questionList.append( ["香港滙豐總行大廈","中環",""]);
        questionList.append( ["合和中心","灣仔",""]);
        questionList.append( ["圓方","柯士甸道西","S"]);
        questionList.append( ["又一城","達之路","S"]);
        questionList.append( ["海港城","尖沙咀",""]);
        questionList.append( ["置地廣場","中環",""]);
        questionList.append( ["上水廣場","龍琛路","S"]);
        questionList.append( ["朗豪坊","旺角",""]);
        questionList.append( ["荷里活廣場","鑽石山",""]);
        questionList.append( ["時代廣場","銅鑼灣",""]);
        questionList.append( ["尖沙咀中心","麼地道","S"]);
        questionList.append( ["帝國中心","尖沙咀",""]);
        questionList.append( ["西港城","上環",""]);
        questionList.append( ["永安百貨","德輔道中","S"]);
        questionList.append( ["黃埔新天地","紅磡",""]);
        questionList.append( ["元創方","鴨巴甸街","S"]);
        questionList.append( ["九展名店倉","展貿徑","S"]);
        questionList.append( ["世貿中心","告士打道","S"]);
        questionList.append( ["金百利商場","記利佐治街","S"]);
        questionList.append( ["K11購物藝術館","河內道","S"]);
        questionList.append( ["青衣城","青敬路","S"]);
        questionList.append( ["新城市廣場","沙田",""]);
        questionList.append( ["奧海城","海庭道","S"]);
        questionList.append( ["崇光百貨","軒尼詩道","S"]);
        questionList.append( ["屯門市廣場","屯順街","S"]);
        questionList.append( ["中港城","尖沙咀",""]);
        questionList.append( ["東薈城名店倉","東涌",""]);
        questionList.append( ["利舞臺","銅鑼灣",""]);
        questionList.append( ["德福花園","偉業街","S"]);
        questionList.append( ["淘大花園","九龍灣",""]);
        questionList.append( ["匯景花園","藍田",""]);
        questionList.append( ["綠楊新邨","荃灣",""]);
        questionList.append( ["盈翠半島","青衣",""]);
        questionList.append( ["藍天海岸","東涌",""]);
        questionList.append( ["港灣豪庭","福利街","S"]);
        questionList.append( ["新屯門中心","龍門路","S"]);
        questionList.append( ["錦綉花園","元朗",""]);
        questionList.append( ["嘉湖山莊","天水圍",""]);
        questionList.append( ["美孚新邨","荔枝角",""]);
        questionList.append( ["太古城","鰂魚涌",""]);
        questionList.append( ["沙田第一城","小瀝源路","S"]);
        questionList.append( ["黃埔花園","紅磡",""]);
        questionList.append( ["海怡半島","鴨脷洲",""]);
        questionList.append( ["麗港城","觀塘",""]);
        questionList.append( ["愉景灣","大嶼山",""]);
        questionList.append( ["新都城","寶林",""]);
        questionList.append( ["康怡花園","鰂魚涌",""]);
        questionList.append( ["杏花邨","柴灣",""]);
        questionList.append( ["麗城花園","荃灣",""]);
        questionList.append( ["海濱花園","荃灣",""]);
        questionList.append( ["映灣園","東涌",""]);
        questionList.append( ["珀麗灣","馬灣",""]);
        questionList.append( ["日出康城","將軍澳",""]);
        questionList.append( ["維景灣畔","調景嶺","S"]);
        questionList.append( ["海逸豪園","紅磡",""]);
        questionList.append( ["置富花園","薄扶林",""]);
        questionList.append( ["荃灣中心","荃景圍","S"]);
        questionList.append( ["將軍澳中心","唐德街","S"]);
        questionList.append( ["新時代廣場(元朗)","元龍路","S"]);
        questionList.append( ["大埔中心","安邦路","S"]);
        questionList.append( ["東堤灣畔","東涌",""]);
        questionList.append( ["大興花園","屯門",""]);
        questionList.append( ["新港城","馬鞍山",""]);
        questionList.append( ["香港恒生大學","小瀝源",""]);
        questionList.append( ["香港城市大學","九龍塘",""]);
        questionList.append( ["香港浸會大學","九龍塘",""]);
        questionList.append( ["香港樹仁大學","北角",""]);
        questionList.append( ["嶺南大學","屯門",""]);
        questionList.append( ["香港中文大學","沙田",""]);
        questionList.append( ["香港教育大學","大埔",""]);
        questionList.append( ["香港理工大學","紅磡",""]);
        questionList.append( ["香港科技大學","清水灣",""]);
        questionList.append( ["香港公開大學","何文田",""]);
        questionList.append( ["香港大學本部大樓","般咸道","S"]);
        
        return questionList;
        
    }
    
    func districtFullList() -> Array<String> {
        
        var districtList = [String]()

        districtList.append( "青衣" )
        districtList.append( "荃灣" )
        districtList.append( "油柑頭" )
        districtList.append( "汀九" )
        districtList.append( "深井" )
        districtList.append( "銅鑼灣" )
        districtList.append( "大坑" )
        districtList.append( "天后" )
        districtList.append( "北角" )
        districtList.append( "跑馬地" )
        districtList.append( "黃泥涌" )
        districtList.append( "上環" )
        districtList.append( "西營盤" )
        districtList.append( "西環" )
        districtList.append( "堅尼地城" )
        districtList.append( "薄扶林" )
        districtList.append( "香港仔" )
        districtList.append( "黃竹坑" )
        districtList.append( "赤柱" )
        districtList.append( "柴灣" )
        districtList.append( "金鐘" )
        districtList.append( "灣仔" )
        districtList.append( "中環" )
        districtList.append( "半山" )
        districtList.append( "山頂" )
        districtList.append( "鰂魚涌" )
        districtList.append( "太古" )
        districtList.append( "西灣河" )
        districtList.append( "筲箕灣" )
        districtList.append( "觀塘" )
        districtList.append( "藍田" )
        districtList.append( "小西灣" )
        districtList.append( "尖沙咀" )
        districtList.append( "柯士甸道西" )
        districtList.append( "油麻地" )
        districtList.append( "旺角" )
        districtList.append( "荔灣道" )
        districtList.append( "長沙灣" )
        districtList.append( "深水步" )
        districtList.append( "石硤尾" )
        districtList.append( "大角咀" )
        districtList.append( "何文田" )
        districtList.append( "紅磡" )
        districtList.append( "馬頭角" )
        districtList.append( "土瓜灣" )
        districtList.append( "馬頭圍" )
        districtList.append( "新蒲崗" )
        districtList.append( "秀茂坪" )
        districtList.append( "油塘" )
        districtList.append( "黃大仙" )
        districtList.append( "牛池灣" )
        districtList.append( "鑽石山" )
        districtList.append( "九龍灣" )
        districtList.append( "牛頭角" )
        districtList.append( "將軍澳" )
        districtList.append( "坑口" )
        districtList.append( "清水灣" )
        districtList.append( "西頁" )
        districtList.append( "馬鞍山" )
        districtList.append( "九龍城" )
        districtList.append( "樂富" )
        districtList.append( "西貢" )
        districtList.append( "啟德" )
        districtList.append( "九龍塘" )
        districtList.append( "大圍" )
        districtList.append( "沙田" )
        districtList.append( "大埔" )
        districtList.append( "小欖" )
        districtList.append( "掃管笏" )
        districtList.append( "屯門" )
        districtList.append( "天水圍" )
        districtList.append( "元朗" )
        districtList.append( "新田" )
        districtList.append( "錦田" )
        districtList.append( "粉嶺" )
        districtList.append( "上水" )
        districtList.append( "赤鱲角" )
        districtList.append( "東涌" )
        districtList.append( "梅窩" )
        districtList.append( "貝澳" )
        districtList.append( "石壁" )
        districtList.append( "昂坪" )
        districtList.append( "大澳" )
        
        return districtList
        
    }
    
    func roadFullList() -> Array<String> {
    
        var roadList = [String]()

        roadList.append( "荔景山路" )
        roadList.append( "荔枝嶺路" )
        roadList.append( "和宜合道" )
        roadList.append( "葵涌道" )
        roadList.append( "新葵街" )
        roadList.append( "興芳路" )
        roadList.append( "永孝街" )
        roadList.append( "青綠街" )
        roadList.append( "青衣鄉事會路" )
        roadList.append( "老圍" )
        roadList.append( "荃景圍" )
        roadList.append( "西樓角路" )
        roadList.append( "大河道" )
        roadList.append( "大壩街" )
        roadList.append( "波斯富街" )
        roadList.append( "禮頓道" )
        roadList.append( "新寧道" )
        roadList.append( "東院道" )
        roadList.append( "英皇道" )
        roadList.append( "渣華道" )
        roadList.append( "成和道" )
        roadList.append( "宏德街" )
        roadList.append( "中港道" )
        roadList.append( "皇后大道中 " )
        roadList.append( "德輔道西" )
        roadList.append( "黃竹坑徑" )
        roadList.append( "黃竹坑道" )
        roadList.append( "深灣道" )
        roadList.append( "南寧街" )
        roadList.append( "赤柱村道" )
        roadList.append( "黃麻角道" )
        roadList.append( "樂民道" )
        roadList.append( "般咸道" )
        roadList.append( "夏愨道" )
        roadList.append( "港灣道" )
        roadList.append( "軍器廠街" )
        roadList.append( "軒尼詩道" )
        roadList.append( "灣仔道" )
        roadList.append( "畢打街" )
        roadList.append( "山頂道" )
        roadList.append( "遮打道" )
        roadList.append( "太康街" )
        roadList.append( "太安街" )
        roadList.append( "筲箕灣道" )
        roadList.append( "柴灣道" )
        roadList.append( "偉業街" )
        roadList.append( "觀塘道" )
        roadList.append( "鯉魚門道" )
        roadList.append( "彌敦道" )
        roadList.append( "麼地道" )
        roadList.append( "眾坊街" )
        roadList.append( "炮台街" )
        roadList.append( "豉油街" )
        roadList.append( "太子道西" )
        roadList.append( "荔枝角道" )
        roadList.append( "聯運街" )
        roadList.append( "花園街" )
        roadList.append( "砵蘭街" )
        roadList.append( "上海街" )
        roadList.append( "長沙灣道" )
        roadList.append( "欽州街" )
        roadList.append( "元州街" )
        roadList.append( "公主道" )
        roadList.append( "忠孝街" )
        roadList.append( "馬頭圍道" )
        roadList.append( "康寧道" )
        roadList.append( "嘉榮街" )
        roadList.append( "正德街" )
        roadList.append( "沙田坳道" )
        roadList.append( "蒲崗村道" )
        roadList.append( "清水灣道" )
        roadList.append( "安華街" )
        roadList.append( "康利道" )
        roadList.append( "展貿徑" )
        roadList.append( "兆業街" )
        roadList.append( "寶琳北路" )
        roadList.append( "寶寧里" )
        roadList.append( "親民街" )
        roadList.append( "普通道" )
        roadList.append( "惠民路" )
        roadList.append( "馬鞍山路" )
        roadList.append( "亞皆老街" )
        roadList.append( "賈炳達道" )
        roadList.append( "達之路" )
        roadList.append( "窩打老道" )
        roadList.append( "富健街" )
        roadList.append( "顯徑街" )
        roadList.append( "源禾路" )
        roadList.append( "上禾輋路" )
        roadList.append( "禾輋街" )
        roadList.append( "銀城街" )
        roadList.append( "插桅杆街" )
        roadList.append( "樂景街" )
        roadList.append( "亞公角街" )
        roadList.append( "澤祥街" )
        roadList.append( "廣福道" )
        roadList.append( "鄉事會坊" )
        roadList.append( "東昌街" )
        roadList.append( "安邦路" )
        roadList.append( "汀角路" )
        roadList.append( "安埔里" )
        roadList.append( "全安路" )
        roadList.append( "海榮路" )
        roadList.append( "湖安街" )
        roadList.append( "龍門路" )
        roadList.append( "屯喜路" )
        roadList.append( "杯渡路" )
        roadList.append( "青賢街" )
        roadList.append( "青松觀路" )
        roadList.append( "天耀路" )
        roadList.append( "青山公路" )
        roadList.append( "元朗體育路" )
        roadList.append( "橋樂坊" )
        roadList.append( "朗日路" )
        roadList.append( "靈山路" )
        roadList.append( "坪輋路" )
        roadList.append( "鳳南路" )
        roadList.append( "龍琛路" )
        roadList.append( "橫洲路" )
        roadList.append( "竹篙灣" )
        roadList.append( "航膳西路" )
        roadList.append( "達東路" )
        roadList.append( "富東路" )
        roadList.append( "銀鑛灣路" )
        roadList.append( "麻埔坪道" )
        roadList.append( "石壁水塘路" )
        roadList.append( "啟田道" )
        
        return roadList
    }
    
}
