import Foundation
import ArgumentParser
import USDServiceProvider


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
            print(USDServiceProvider().usdcatHelp())
        }
    }
    
    struct makecrate:ParsableCommand {
        
//        @Argument(help: "The phrase to repeat.")
//        var phrase: String
        
        @Argument(help: "The input file") var inputFile: String
        @Argument(help: "The output file") var outputFile: String?
        
        func run() throws {
            print("hello")
//            let inputFile = "/Users/carlynorama/Developer/GitHub/USDTestingCLI/compress_me.usda"
//            let outputFile = "/Users/carlynorama/Developer/GitHub/USDTestingCLI/compressed.usdc"
            USDServiceProvider().makeUSDC(inputFile: inputFile, outputFile: outputFile ?? "compressed.usdc")
        }
    }
}

///Users/carlynorama/opd/USD_nopython_0722/bin

