class CampusRepository{
    
    
    typealias Resto = (campus: String, naam: String, id: String)

    
    var campussen :[String] = ["--default--", "Aalst", "Bijloke", "Mercator", "Ledeganck", "Melle", "Schoonmeersen", "Vesalius"]
    
    var restos :[Resto] =
        [(campus: "Schoonmeersen", naam: "--default--", id: ""),
         (campus: "Schoonmeersen", naam: "Resto B", id: "-KUgzAKmMl-PQ629mYxu"),
         (campus: "Schoonmeersen", naam: "Resto C",id: "-KUgzAL6jZD4P7JOoQh_"),
         (campus: "Schoonmeersen", naam: "Resto D",id: "-KUgzAL7A0ru7gngZn7X"),
         (campus: "Schoonmeersen", naam: "Resto P", id: "-KUgzAL8RvpuB3zOUmS8"),
         (campus: "Schoonmeersen", naam: "Java Coffe store", id: "-KUgzAL9-gm9Gb-_xhu5"),
         (campus: "Ledeganck", naam: "--default--", id: ""),
         (campus: "Ledeganck", naam: "Resto Ledeganck", id: "-KUgzALA8xZPdIsJcGB0"),
         (campus: "Bijloke", naam: "--default", id: ""),
         (campus: "Bijloke", naam: "Resto Bijloke", id: "-KUh6ekMn7N1EWZH8u37"),
         (campus: "Mercator", naam: "--default--", id: ""),
         (campus: "Mercator", naam: "Resto Mercator", id: "-KUh6ekUj7LoPwPnvK9H"),
         (campus: "Melle", naam: "--default--", id: ""),
         (campus: "Melle", naam: "Resto Melle", id: "-KUh6ekWADMLW-yqGdph"),
         (campus: "Vesalius", naam: "--default--", id: ""),
         (campus: "Vesalius", naam: "Resto Vesalius", id: "-KUh6ekWADMLW-yqGdpi"),
         (campus: "Mercator", naam: "Resto De Wijnaert", id: "-KUh6ekXgG0kLXOjXKFc"),
         (campus: "Aalst", naam: "--default--", id: ""),
         (campus: "Aalst", naam: "Cafetaria Aalst", id: "-KUh6ekYBBD5Xp-rxscN")]
    
    
    func getRestos(of campus: String) -> [Resto] {
        if campus.isEmpty || campus.lowercased() == "--default--" {
            return restos
        }
        return restos.filter {$0.0.lowercased() == campus.lowercased()}
    }
}
