import Foundation
import ArgumentParser
import USDServiceProvider

let USDBuild = "/Users/carlynorama/opd/USD_nousdview_py3_10_0723/"

@main
public struct USDTestingCLI:ParsableCommand {
    public static let configuration = CommandConfiguration(
        
        abstract: "A Swift command-line tool",
        version: "0.0.1",
        subcommands: [
            test.self,
            makecrate.self
        ],
        defaultSubcommand: makecrate.self)
    
    public init() {}
    
    struct test:ParsableCommand {
        func run() throws {
            print(USDServiceProvider(pathToUSDBuild:USDBuild).usdcatHelp())
        }
    }
    
    struct makecrate:ParsableCommand {
        
        @Argument(help: "The input file") var inputFile: String
        @Argument(help: "The output file") var outputFile: String?
        
        func run() throws {
            let usdSP = USDServiceProvider(pathToUSDBuild: USDBuild)
            print("hello")
            usdSP.makeCrate(from: inputFile, outputFile: outputFile ?? "compressed_sunday.usdc")
            usdSP.check(inputFile)
        }
    }
}

///Users/carlynorama/opd/USD_nopython_0722/bin

//            let inputFile = "/Users/carlynorama/Developer/GitHub/USDTestingCLI/compress_me.usda"
//            let outputFile = "/Users/carlynorama/Developer/GitHub/USDTestingCLI/compressed.usdc"
