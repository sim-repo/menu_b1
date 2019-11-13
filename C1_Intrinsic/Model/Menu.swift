import Foundation


class MenuItem {
    var id: Int
    var title: String
    var selected: Bool = false
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}


class Menu {
    var id: Int = 0
    var title: String?
    var menuItems: [Int:String]
    var indexPath: IndexPath
    var parentIndexPath: IndexPath
    var isFilter: Bool = false
    var menuItem: [Int:MenuItem] = [:]
    
    
    init(id: Int, title: String, menuItems:  [Int:String], curr: IndexPath, parent: IndexPath, isFilter: Bool = false) {
        self.id = id
        self.title = title
        self.menuItems = menuItems
        self.indexPath = curr
        self.parentIndexPath = parent
        self.isFilter = isFilter
        
        for item in menuItems {
            menuItem[item.key] = MenuItem(id: item.key, title: item.value)
        }
    }
    
    public static func list() -> [Menu] {
        
        var filters = [Int:String]()
        filters[0] = "Страна"
        filters[1] = "Цвет"
        filters[2] = "Цена"
        filters[3] = "Сорт Винограда"
        filters[4] = "Объем"
        filters[5] = "Производитель"
        
        
        
        // level # 1
        var country = [Int:String]()
        country[0] = "Франция"
        country[1] = "Италия"
        country[2] = "Испания"
        country[3] = "Чили"
        country[4] = "Германия"
        
        var colors = [Int:String]()
        colors[0] = "Красное"
        colors[1] = "Белое"
        colors[2] = "Розовое"

        
        var price = [Int:String]()
        price[0] = "до 1 500 ₽"
        price[1] = "от 1 500 до 3 000 ₽"
        price[2] = "от 3 000 до 5 000 ₽"
        price[3] = "от 10 000 ₽"
        
        var sort = [Int:String]()
        sort[0] = "алиберне (одесский черный)"
        sort[1] = "аликанте"
        sort[2] = "альбариньо"
        sort[3] = "альянико"
        sort[4] = "амарал"
        sort[5] = "ансоника (инзолия)"
        sort[6] = "аринто"
        sort[7] = "арнеис"
        sort[8] = "асал"
        sort[9] = "барбера"
        sort[10] = "бастардо магарачский"
        sort[11] = "белые сорта винограда"
        sort[12] = "блауфренкиш"
        sort[12] = "боваледду"
        sort[13] = "бонарда"
        sort[14] = "боррасал"
        sort[15] = "бурбуленк"
        sort[16] = "буше (каберне фран)"
        sort[17] = "бьянколлела"
        sort[18] = "верделло"
        sort[19] = "вердехо"
        sort[20] = "вердиккио"
        sort[21] = "верментино"
        sort[22] = "весполина"
        sort[23] = "виньяо"
        sort[24] = "виозиньо"
        sort[25] = "вионье"
        sort[26] = "витовска"
        sort[27] = "виура"
        sort[28] = "гальоппо"
        sort[29] = "гаме"
        sort[30] = "гарганега"
        sort[31] = "гарнача"
        sort[32] = "гевюрцтраминер"
        sort[33] = "годельо"
        sort[34] = "грасиано"
        sort[35] = "греканико"
        sort[36] = "грекетто"
        sort[37] = "греко"
        sort[38] = "греко неро"
        sort[39] = "гренаш"
        sort[40] = "гренаш блан"
        sort[41] = "грилло"
        sort[42] = "гро мансенг"
        sort[43] = "грюнер вельтлинер"
        sort[44] = "джинестра"
        sort[45] = "дзибиббо (мускат александрийский)"
        sort[46] = "дольчетто"
        sort[47] = "другие сорта"
        sort[48] = "зинфандель"
        sort[49] = "инзолия (ансоника)"
        sort[50] = "каберло"
        sort[51] = "каберне совиньон"
        sort[52] = "каберне фран"
        sort[53] = "канайоло"
        sort[54] = "кариньян"
        sort[55] = "кариньяно"
        sort[56] = "карменер"
        sort[57] = "катарратто"
        sort[58] = "кахури мцване"
        sort[59] = "киси"
        sort[60] = "клерет"
        sort[61] = "кода ди вольпе"
        sort[62] = "кодега"
        sort[63] = "коломбар"
        sort[64] = "колорино"
        sort[65] = "корвина веронезе"
        sort[66] = "корвиноне"
        sort[67] = "кортезе"
        sort[68] = "красные сорта винограда"
        sort[69] = "кроатина"
        sort[70] = "лагрейн"
        sort[71] = "лаурейро"
        sort[72] = "мальбек"
        sort[73] = "мальвазия"
        sort[74] = "мальвазия бьянка"
        sort[75] = "мальвазия истриана"
        sort[76] = "мальвазия нера"
        sort[77] = "мальвазия фина"
        sort[78] = " манцони бьянко"
        sort[79] = "марсан"
        sort[80] = "масуэло"
        sort[81] = "матаро"
        sort[82] = "менсия"
        sort[83] = "мерло"
        sort[84] = "молинара"
        sort[85] = "монастрель"
        sort[86] = "моника"
        sort[87] = "монтепульчано"
        sort[88] = "москатель"
        sort[89] = "москатель де грано менудо"
        sort[90] = "мурведр"
        sort[91] = "мускат"
        sort[92] = "мускат гамбургский"
        sort[93] = "мускат желтый"
        sort[94] = "мускат люнель"
        sort[95] = "мюллер тургау"
        sort[96] = "мюскадель"
        sort[97] = "мюскарден"
        
      

        
        
        var volume = [Int:String]()
        volume[0] = "3"
        volume[1] = "6"
        volume[2] = "0.187"
        volume[3] = "0.2"
        volume[4] = "0.375"
        volume[5] = "0.5"
        volume[6] = "0.7"
        volume[7] = "0.73"
        volume[8] = "0.75"
        volume[9] = "1.5"

        var producer = [Int:String]()
        producer[0] = "Achaval-Ferrer"
        producer[1] = "Alain Gras"
        producer[2] = "Bodegas Chivite"
        producer[3] = "Bodegas Horacio Gomez Araujo"
        producer[4] = "Bodegas Palacios Remondo"
        producer[5] = "Canti"
        producer[6] = "Chateau de la Gardine"
        producer[7] = "Domain du Cros"
        producer[8] = "Domaine Curtet"
        producer[9] = "Sileni"
        
        
        
        // level # 2
        var france = [Int:String]()
        france[0] = "Лангедок-Руссильон"
        france[1] = "Прованс"
        france[2] = "Юго-Запад"
        
        var italy = [Int:String]()
        italy[0] = "Абруццо"
        italy[1] = "Апулия"
        italy[2] = "Венето"
        italy[3] = "Калабрия"
        italy[4] = "Кампания"
        italy[5] = "Лацио"
        italy[6] = "Марке"
        italy[7] = "Пьемонт"
        italy[8] = "Сардиния"
        italy[9] = "Сицилия"
        italy[10] = "Тоскана"
        italy[11] = "Трентино-Альто Адидже"
        italy[12] = "Умбрия"
        italy[13] = "Фриули-Венеция-Джулия"
        italy[14] = "Эмилия-Романья"
        
        var spain = [Int:String]()
        spain[0] = "Валенсия"
        spain[1] = "Галисия"
        spain[2] = "Кастилия Ла Манча"
        spain[3] = "Кастилья и Леон"
        spain[4] = "Каталония"
        spain[5] = "Риоха"
        
        
        var chili = [Int:String]()
        chili[0] = "Аконкагуа"
        chili[1] = "Центральная Долина"
     
        
        
        return [
            Menu(id: 0, title: "Фильтры", menuItems: filters, curr: IndexPath(row: -1, section: 0), parent: IndexPath(row: -1, section: 0)),
            
            // level # 1
            Menu(id: 1, title: "Страна", menuItems: country, curr: IndexPath(row: 0, section: 1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            Menu(id: 2, title: "Цвет", menuItems: colors, curr: IndexPath(row: 1, section: 1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            Menu(id: 3, title: "Цена", menuItems: price, curr: IndexPath(row: 2, section: 1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            Menu(id: 4, title: "Сорт Винограда", menuItems: sort, curr: IndexPath(row: 3, section:1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            Menu(id: 5, title: "Объем", menuItems: volume, curr: IndexPath(row: 4, section:1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            Menu(id: 6, title: "Производитель", menuItems: producer, curr: IndexPath(row: 5, section:1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            
            
            // level # 2
            Menu(id: 7, title: "Регион", menuItems: france, curr: IndexPath(row: 0, section: 2), parent: IndexPath(row: 0, section: 1)),
            Menu(id: 8, title: "Регион", menuItems: italy, curr: IndexPath(row: 1, section: 2), parent: IndexPath(row: 0, section: 1)),
            Menu(id: 9, title: "Регион", menuItems: spain, curr: IndexPath(row: 2, section: 2), parent: IndexPath(row: 0, section: 1)),
            Menu(id: 10, title: "Регион", menuItems: chili, curr: IndexPath(row: 3, section: 2), parent: IndexPath(row: 0, section: 1))
            
        ]
    }
}
