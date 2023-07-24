import Foundation
import ArgumentParser
import USDServiceProvider

//MARK: --------------------- YOUR SETUP GOES HERE ------------------------
let USDBuild = "/Users/carlynorama/opd/USD_nousdview_py3_10_0723/"
let pythonEnv:USDServiceProvider.PythonEnvironment = .pyenv("3.10")

@main
public struct USDTestingCLI:ParsableCommand {
    public static let configuration = CommandConfiguration(
        
        abstract: "A Swift command-line tool",
        version: "0.0.1",
        subcommands: [
            //testusdcat.self,
            checkncrate.self,
            helloworld.self,
            teststring.self
        ],
        defaultSubcommand: teststring.self)
    
    public init() {}
    
//    struct testusdcat:ParsableCommand {
//        func run() throws {
//            print(USDServiceProvider(pathToUSDBuild:USDBuild, pythonEnv: pythonEnv).usdcatHelp())
//        }
//    }
    
    struct checkncrate:ParsableCommand {
        
        @Argument(help: "The input file") var inputFile: String
        @Argument(help: "The output file") var outputFile: String?
        
        func run() throws {
            
            //TODO: fragile. if cli sticks around, improve.
            let outputFilePath = outputFile ?? inputFile.replacingOccurrences(of: ".usda", with: ".usdc")
            
            let usdSP = USDServiceProvider(pathToUSDBuild: USDBuild, pythonEnv: pythonEnv)
            
            print("hello")
            
            let reuslt = usdSP.check(filePath: inputFile)
            print(reuslt)
            usdSP.makeCrate(from: inputFile, outputFile: outputFilePath)
        }
    }
    
    struct helloworld:ParsableCommand {
        @Argument(help: "The output file") var outputFile: String?
        
        func run() throws {
            
            //TODO: also fragile. if cli sticks around, improve.
            let outputFilePath = outputFile ?? "~/Documents/hello_world.usda"
            
            let usdSP = USDServiceProvider(pathToUSDBuild: USDBuild, pythonEnv: pythonEnv)
            usdSP.saveHelloWorld(to: outputFilePath)
        }
    }
    
    struct teststring:ParsableCommand {
        
        func run() {
            let usdSP = USDServiceProvider(pathToUSDBuild: USDBuild, pythonEnv: pythonEnv)
            let result = usdSP.check(string: mockdata)
            print(result)
        }
        
        
        var mockdata:String = """
#usda 1.0
(
    startTimeCode = 1
    endTimeCode = 10
    upAxis = "Z"
)
def SkelRoot "Model"(
    prepend apiSchemas = ["SkelBindingAPI"]
)
{
    def Skeleton "Skel"(
        prepend apiSchemas = ["SkelBindingAPI"]
    )
    {
        uniform token[] joints = ["Shoulder", "Shoulder/Elbow", "Shoulder/Elbow/Hand"]
        uniform matrix4d[] bindTransforms = [
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,4,1))
        ]
        uniform matrix4d[] restTransforms = [
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1)),
            ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,2,1))
        ]
        def SkelAnimation "Anim1" {
            uniform token[] joints = ["Shoulder/Elbow"]
        
            float3[] translations = [(0,0,2)]
            quatf[] rotations.timeSamples = {
                1: [(1,0,0,0)],
                10: [(0.7071, 0.7071, 0, 0)]
            }
            half3[] scales = [(1,1,1)]
        }
        
        rel skel:animationSource = <Anim1>
    }
    rel skel:skeleton = </Model/Skel>

    def Mesh "Arm" (
        prepend apiSchemas = ["SkelBindingAPI"]
    )
    {
 
       int[] faceVertexCounts = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
       int[] faceVertexIndices = [
           2, 3, 1, 0,
           6, 7, 5, 4,
           8, 9, 7, 6,
           3, 2, 9, 8,
           10, 11, 4, 5,
           0, 1, 11, 10,
           7, 9, 10, 5,
           9, 2, 0, 10,
           3, 8, 11, 1,
           8, 6, 4, 11
       ]
       point3f[] points = [
           (0.5, -0.5, 4), (-0.5, -0.5, 4), (0.5, 0.5, 4), (-0.5, 0.5, 4),
           (-0.5, -0.5, 0), (0.5, -0.5, 0), (-0.5, 0.5, 0), (0.5, 0.5, 0),
           (-0.5, 0.5, 2), (0.5, 0.5, 2), (0.5, -0.5, 2), (-0.5, -0.5, 2)
       ]
       # Authored normals should be ignored on skinned meshes.
       normal3f[] normals = [
           (0,0,1), (0,0,1), (0,0,1), (0,0,1),
           (0,0,1), (0,0,1), (0,0,1), (0,0,1),
           (0,0,1), (0,0,1), (0,0,1), (0,0,1)
       ]
       int[] primvars:skel:jointIndices = [
           2,2,2,2, 0,0,0,0, 1,1,1,1
       ] (
           interpolation = "vertex"
           elementSize = 1
       )
       float[] primvars:skel:jointWeights = [
           1,1,1,1, 1,1,1,1, 1,1,1,1
        ] (
           interpolation = "vertex"
           elementSize = 1
       )
       matrix4d primvars:skel:geomBindTransform = ((1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1))
    }
}
"""
    }
    
    
}
