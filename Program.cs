using System;
using System.IO;

namespace NukeBin
{
    class Program
    {
        static int Main(string[] args)
        {
            // Check if command line argument is provided
            if (args.Length == 0)
            {
                Console.WriteLine("Usage: NukeBin <path>");
                Console.WriteLine("Example: NukeBin C:\\MyProject");
                return 1;
            }

            string targetPath = args[0];

            // Validate that the path exists
            if (!Directory.Exists(targetPath))
            {
                Console.WriteLine($"Error: The specified path '{targetPath}' does not exist.");
                return 1;
            }

            try
            {
                Console.WriteLine($"Starting cleanup of 'bin' and 'obj' folders in: {targetPath}");
                Console.WriteLine();

                int deletedFolders = DeleteBinAndObjFolders(targetPath);

                Console.WriteLine();
                Console.WriteLine($"Cleanup completed. Deleted {deletedFolders} folder(s).");
                return 0;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error during cleanup: {ex.Message}");
                return 1;
            }
        }

        static int DeleteBinAndObjFolders(string directoryPath)
        {
            int deletedCount = 0;

            try
            {
                // Get all subdirectories
                string[] subdirectories = Directory.GetDirectories(directoryPath);

                foreach (string subdirectory in subdirectories)
                {
                    string folderName = Path.GetFileName(subdirectory);

                    // Check if this is a 'bin' or 'obj' folder
                    if (string.Equals(folderName, "bin", StringComparison.OrdinalIgnoreCase) ||
                        string.Equals(folderName, "obj", StringComparison.OrdinalIgnoreCase))
                    {
                        try
                        {
                            Console.WriteLine($"Deleting: {subdirectory}");
                            Directory.Delete(subdirectory, true); // true = recursive deletion
                            deletedCount++;
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Warning: Could not delete '{subdirectory}': {ex.Message}");
                        }
                    }
                    else
                    {
                        // Recursively search in this subdirectory
                        deletedCount += DeleteBinAndObjFolders(subdirectory);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Warning: Could not access directory '{directoryPath}': {ex.Message}");
            }

            return deletedCount;
        }
    }
}
