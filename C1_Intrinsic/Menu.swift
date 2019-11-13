import Foundation


class Menu {
    var id: Int = 0
    var title: String?
    var menuItems: [Int:String]
    var indexPath: IndexPath
    var parentIndexPath: IndexPath
    var isFilter: Bool = false
    
    init(id: Int, title: String, menuItems:  [Int:String], curr: IndexPath, parent: IndexPath, isFilter: Bool = false) {
        self.id = id
        self.title = title
        self.menuItems = menuItems
        self.indexPath = curr
        self.parentIndexPath = parent
        self.isFilter = isFilter
    }
    
    public static func list() -> [Menu] {
        
        var filters = [Int:String]()
        filters[0] = "Seasons"
        filters[1] = "Colors"
        filters[2] = "Shape"
        filters[3] = "Temperature"
    
        
        // level # 1
        var seasons = [Int:String]()
        seasons[0] = "autumn"
        seasons[1] = "summer"
        seasons[2] = "winter"
        seasons[3] = "spring"
        
        var colors = [Int:String]()
        colors[0] = "red"
        colors[1] = "green"
        colors[2] = "blue"
        colors[3] = "orange"
        
        var shape = [Int:String]()
        shape[0] = "square"
        shape[1] = "triangle"
        shape[2] = "circle"

        
        var temperature = [Int:String]()
        temperature[0] = "cold"
        temperature[1] = "warm"
        temperature[2] = "hot"
        
        
        // level # 2
        var rColors = [Int:String]()
        rColors[0] = "cherry"
        rColors[1] = "garnet"
        rColors[2] = "candy"
        rColors[3] = "ruby"
        
        var gColors = [Int:String]()
        gColors[0] = "olive"
        gColors[1] = "tea"
        gColors[2] = "sage"
        gColors[3] = "mint"
        
        
        var bColors = [Int:String]()
        bColors[0] = "steel"
        bColors[1] = "carolina"
        bColors[2] = "azure"
        bColors[3] = "navy"
        
        
        var oColors = [Int:String]()
        oColors[0] = "bronse"
        oColors[1] = "carrot"
        oColors[2] = "clay"
        oColors[3] = "cider"
        
        
        
        var alpha = [Int:String]()
               alpha[0] = "alpha1"
               alpha[1] = "alpha2"
               alpha[2] = "alpha3"
               alpha[3] = "alpha4"
               alpha[4] = "alpha5"
                alpha[5] = "alpha6"
                alpha[6] = "alpha7"
                alpha[7] = "alpha8"
                alpha[8] = "alpha9"
                alpha[9] = "alpha10"
                alpha[10] = "alpha11"
                alpha[11] = "alpha12"
                alpha[12] = "alpha13"
                alpha[13] = "alpha14"
        
        var beta = [Int:String]()
               beta[0] = "beta1"
               beta[1] = "beta2"
               beta[2] = "beta3"
               beta[3] = "beta4"
        
        
        return [
            Menu(id: 0, title: "Filters", menuItems: filters, curr: IndexPath(row: -1, section: 0), parent: IndexPath(row: -1, section: 0)),
            
            // level # 1
            Menu(id: 1, title: "Season", menuItems: seasons, curr: IndexPath(row: 0, section: 1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            Menu(id: 2, title: "Colors", menuItems: colors, curr: IndexPath(row: 1, section: 1), parent: IndexPath(row: -1, section: 0)),
            Menu(id: 3, title: "Shape", menuItems: shape, curr: IndexPath(row: 2, section: 1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            Menu(id: 4, title: "Temperature", menuItems: temperature, curr: IndexPath(row: 3, section:1), parent: IndexPath(row: -1, section: 0), isFilter: true),
            
            
            // level # 2
            Menu(id: 5, title: "Red Colors", menuItems: rColors, curr: IndexPath(row: 0, section: 2), parent: IndexPath(row: 1, section: 1)),
            Menu(id: 6, title: "Green Colors", menuItems: gColors, curr: IndexPath(row: 1, section: 2), parent: IndexPath(row: 1, section: 1)),
            Menu(id: 7, title: "Blue Colors", menuItems: bColors, curr: IndexPath(row: 2, section: 2), parent: IndexPath(row: 1, section: 1)),
            Menu(id: 8, title: "Orange Colors", menuItems: oColors, curr: IndexPath(row: 3, section: 2), parent: IndexPath(row: 1, section: 1)),
            
            
            // level # 3
            Menu(id: 9, title: "Alpha", menuItems: alpha, curr: IndexPath(row: 0, section: 3), parent: IndexPath(row: 0, section: 2), isFilter: true),
            Menu(id: 10, title: "Beta", menuItems: beta, curr: IndexPath(row: 1, section: 3), parent: IndexPath(row: 0, section: 2), isFilter: true)
            
        ]
    }
}
