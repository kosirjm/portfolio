/** A simple (dummy) file system driver based on FUSE */

// Use latest version of FUSE API
#define FUSE_USE_VERSION 26

#include <fuse.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <math.h>

struct FileInfo {
    char name[16];  // Name of file
    int  fileSize;  // logical size in bytes
    int  day;       // day when file was logically created
    int  hour;      // the hour when file was logically created
    char data;      // The character to be repeated for data
};

// Define an array of structures with preset values to make life easier
const struct FileInfo RootDirEntries[] = {
    {"/STARS.TXT", 256, 6, 5, '*'},
    {"/pounds.txt", 128, 8, 9, '#'},
    {"/percentage", 64, 10, 11, '%'}
};

// Define a constant for number of files to be processed
const int MaxFiles = 3;

// Helper function to search for a valid entry in RootDirEntries list
// See implementation towards end of this file.
int getIndex(const char *path);

// Helper function to get absolute time from given day, month, hour, & minute
// See implementation towards end of this file.
time_t getAbsTime(int day, int month, int hour, int minute);

/** Get's the attribute for a given file or the root directory.

    This is a FUSE API function that is used to obtain the file
    attributes for a given file or directory.  This method only
    handles entries for the root directory.

    \param[in] path The path to the file whose attributes are to be
    retrieved.

    \param[out] stbuf The Linux stat buffer to be populated.

    \return This method returns 0 on success or -ENOENT on errors.
*/
int simple_getattr(const char *path, struct stat *stbuf) {
    // Clear out the stat buffer first.
    memset(stbuf, 0, sizeof(struct stat));
    // Handle root directory suitably.
    time_t time     = getAbsTime(1, 10, 0, 0);
    
    if (strcmp(path, "/") == 0) {
        stbuf->st_mode  = S_IFDIR | 0755;
        stbuf->st_nlink = 2;
        stbuf->st_size  = 4096;
    } else {
        stbuf->st_mode  = S_IFREG | 0444;
        // Ensure that this file name is valid! If not return -ENOENT.
        // The getIndex() function will be handy here.
	if(getIndex(path) == -1){
	  return -ENOENT;
	    }

        // Change time to correspond to the file creation time.
	
	
        // Setup size of the file in st_size. Setup number of links to 1.
	
    }
    // Setup default attributes for the various entries
    stbuf->st_uid   = getuid();
    stbuf->st_gid   = getuid();
    stbuf->st_atime = time;
    stbuf->st_mtime = time;
    stbuf->st_ctime = time;
    
    return 0; // success
}

/** FUSE API method to read all file entries in a given directory.

    This is a convenience method that is used to read all the root
    directory entries into the given buffer. This function currently
    handles only root directory entries.  Consequently, the path must
    be "/".

*/
int simple_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
                  off_t offset, struct fuse_file_info *fi) {
    // Tell compiler we are intentionally not using 2 parameters
    (void) offset;
    (void) fi;
    // Only handle root directory entry
    if (strcmp(path, "/") != 0) {
        return -ENOENT;
    }
    // Setup default entries for current and parent dir. Populate
    // necessary entries using RootDirEntries array.
    int i = 0;   
    off_t ignored = 0;
    
    while(i < MaxFiles){
    filler(buf, "..", RootDirEntries[i].name, ignored);
    }
    return 0;
}


int simple_read(const char *path, char *buf, size_t size, off_t offset,
               struct fuse_file_info *fi) {
    // Tell compiler we are intentionally not using 1 parameter
    (void) fi;
    // Check if path is valid. The getIndex function would be a handy
    
    // Get the information for the file
    // struct FileInfo entry = RootDirEntries[index];

    // Copy the required number of characters into the buffer. Don't
    // forget to handle the trailing newline character that is
    // logically assumed to be the last character in the file.

    // Return the actual number of bytes placed in buf
    
}

// --------------------------------------------------------------
//    DO  NOT  MODIFY  CODE  BELOW  THIS  LINE
// --------------------------------------------------------------

/** Convenience method to convert date and time to a calendar time
    value.  Calendar time value represents the number of seconds
    elapsed since the Epoch, 1970-01-01 00:00:00 +0000 (UTC).

    \param[in]  day The day of the month to be used (1 to 31)
 
    \param[in] month The month of the year associated with the dat (1 to 12)

    \param[in] hour The hour of the day (0 to 23)

    \param[in] minute The minute of the day (0 to 59)

    \return The absolute time in milliseconds since Epoch.
*/
time_t getAbsTime(int day, int month, int hour, int minute) {
    struct tm dateTime;    
    dateTime.tm_mon  = month - 1;
    dateTime.tm_mday = day;
    dateTime.tm_year = 2014 - 1900;  // Offset since 1900
    dateTime.tm_hour = hour;
    dateTime.tm_min  = minute;
    dateTime.tm_sec  = 0; // Set seconds to zero for now
    return mktime(&dateTime);
}

/** Convenience method to search for a given file

    \param[path] The name of the file to search for.

    \return This method returns the index where the file was found or
    -1 if the file was not found.
*/
int getIndex(const char* path) {
    int index = 0;
    for(index = 0; (index < MaxFiles); index++) {
        if (strcmp(RootDirEntries[index].name, path) == 0) {
            return index;
        }
    }
    return -1;
}

/**
    This function just ensures that the path to the file. Other than
    that the open function does not have much work to do in this
    driver.  In other drivers it would have additional work to do.
 */
int simple_open(const char *path, struct fuse_file_info *fi) {
    // Tell compiler we are intentionally not using 1 parameter
    (void) fi;
    // Ensure that the file is valid and is not a directory etc.
    if (getIndex(path) == -1) {
        return -ENOENT;
    }
    // We just logically assume this file to be now open. We don't really
    // use inode information etc.
    return 0;
}

struct fuse_operations simple_oper = {
    .getattr = simple_getattr,
    .readdir = simple_readdir,
    .open    = simple_open,
    .read    = simple_read,
};

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <MountPoint>\n", argv[0]);
        return 1;
    }
    // Startup the FUSE driver system
    int retVal = fuse_main(argc, argv, &simple_oper, NULL);
    // Return status back
    return retVal;
}

// End of source code.
