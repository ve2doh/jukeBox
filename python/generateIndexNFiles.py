import sys, getopt, os, shutil


def main(argv):
    lastnumber=1
    inputFolder = ""
    outputFolder = ""
    opts, args = getopt.getopt(argv,"hi:o:s:",["ifile=","ofile=", "start"])
    for opt, arg in opts:
        if opt== '-h':
            print ('generateIndexNFiles -i <input folder> -o <output folder> -s <start number>')
            sys.exit()
        elif opt in ("-i", "--ifolder"):
            inputFolder = arg
            print ('input folder: ', inputFolder)
        elif opt in ("-o", "--ofolder"):
            outputFolder = arg
            print ('Output folder: ', outputFolder)
        elif opt in ("-s", "--startNumb"):
            lastnumber = int(arg)
            print ('start number: ', lastnumber)

    for dirpath, dirnames, filenames in os.walk(inputFolder):
        for file in filenames:
            newFileName = "{}{:05d}.mp3".format(outputFolder,lastnumber)
            print("current file name: {} - {}".format(lastnumber, file))
            shutil.copy2(os.path.join(dirpath, file), newFileName)

            indexFile = open("{}index.txt".format(outputFolder), "a")
            indexFile.write("{: 5d} - {}\n".format(lastnumber, file))
            indexFile.close()
            
            lastnumber=lastnumber+1


if __name__ == "__main__":
   main(sys.argv[1:])
        
        


