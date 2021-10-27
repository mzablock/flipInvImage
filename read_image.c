#include "stdio.h" 
#include "stdlib.h"
#include "svdpi.h"
#pragma pack(push,1)

typedef struct
{
    unsigned char type[2] ;  
    unsigned int fileSize;
    unsigned short reserved1;
    unsigned short reserved2;
    unsigned int offset;
}BmpHeader;

typedef struct
{
    unsigned int headerSize;
    unsigned int width;
    unsigned int height;
    unsigned short planeCount;
    unsigned short bitDepth;
    unsigned int compression;
    unsigned int compressedImageSize;
    unsigned int horizontalResolution;
    unsigned int verticalResolution;
    unsigned int numColors;
    unsigned int importantColors;

}BmpImageInfo;

typedef struct
{
    unsigned char blue;
    unsigned char green;
    unsigned char red;
    //unsigned char reserved;
}Rgb;

typedef struct
{
    BmpHeader header;
    BmpImageInfo info;
    Rgb colors[256];
    unsigned short image[1];
}BmpFile;

int read_image (const svOpenArrayHandle h) { 
FILE *inFile, *outFile;
BmpHeader header;
BmpImageInfo info;
Rgb *palette, *p;
int i = 0;


inFile = fopen("pict.bmp", "rb");
if( !inFile )
   return;

if( fread(&header, sizeof(BmpHeader), 1, inFile) != 1 )
   return; // Manage error and close file


if( fread(&info, sizeof(BmpImageInfo), 1, inFile) != 1 )
   return; // Manage error and close file
  
printf(" RGB values %d %d %d \n", info.compressedImageSize, info.width,info.height);

   palette = (Rgb*)malloc(sizeof(Rgb) * info.width * info.height);
   fread(palette, sizeof(Rgb), info.width * info.height, inFile);  

 

fclose(inFile);
int ii,jj;
int rgb[320*240-1]; 

for( i=0; i<(320*240-1); ++i ) { 
   p = &palette[i];
  rgb[i] = palette[i].red   + palette[i].green*256 + palette[i].blue*65536  ; 
   *(int *) svGetArrElemPtr(h,i) = rgb[i]; 
}
}



