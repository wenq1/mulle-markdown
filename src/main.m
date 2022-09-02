#define _DEFAULT_SOURCE

#import "import-private.h"

#include "mulle-markdown-version.h"

#include <stdio.h>


// https://www.w3.org/TR/html-polyglot/
// why not...

static char   header1[] = \
"<!DOCTYPE html>\n"
"<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"\" xml:lang=\"\">\n"
"<head>\n"
"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>\n";

static char   css[] = \
"<link rel=\"stylesheet\" href=\"style.css\">\n";

static char   header2[] = \
"<title>%s</title>\n"
"</head>\n"
"<body>\n";

static char   footer[] = \
"</body>\n"
"</html>\n";


static void   usage( void)
{
   fprintf( stderr, "" \
"Usage:\n"
"   mulle-markdown [options]\n"
"\n"
"   Reads markdown from stdin, writes it to stdout.\n"
"\n"
"Options:\n"
"   -c         : emit link to \"style.css\" (implies -w)\n"
"   -i         : inline \"style.css\" into HTML head (implies -w)\n"
"   -t <title> : set title of HTML document (implies -w)\n"
"   -w         : wrap with HTML header and footer\n"
);

   exit( 1);
}


int  main( int argc, char *argv[])
{
   NSMutableData   *data;
   NSData          *markdownedData;
   auto char       buf[ 4096];
   char            *p;
   char            *sentinel;
   int             c;
   int             i;
   FILE            *fq;
   struct
   {
      int   add_header;
      int   add_css;
      int   add_footer;
      int   inline_css;
      char  *title;
   } config;

   memset( &config, 0, sizeof( config));
   config.title = "";

   i = 1;
   while( i < argc)
   {
      if( argv[ i][ 0] == '-')
         switch( argv[ i][ 1])
         {
         case 'h' :
            usage();
            break;

         case 'i' :
            config.inline_css = YES;
            config.add_header = YES;
            config.add_footer = YES;
            ++i;
            continue;

         case 'w' :
            config.add_header = YES;
            config.add_footer = YES;
            ++i;
            continue;

         case 't' :
            if( ++i >= argc)
               usage();

            config.title      = argv[ i];
            config.add_header = YES;
            config.add_footer = YES;
            ++i;
            continue;

         case 'c' :
            config.add_header = YES;
            config.add_footer = YES;
            config.add_css    = YES;
            ++i;
            continue;
         }

      fprintf( stderr, "unknown argument \"%s\"\n", argv[ i]);
      usage();
   }

   if( i != argc)
   {
      fprintf( stderr, "unknown argument \"%s\"\n", argv[ i]);
      usage();
   }

   // as we don't want the dependency on MulleObjCOSFoundation we handcode
   // the reader and writer

   data = [NSMutableData data];

   p        = buf;
   sentinel = &buf[ sizeof( buf)];
   for(;;)
   {
      c = getchar_unlocked();
      if( c == EOF || p == sentinel)
      {
         [data appendBytes:buf
                    length:p - buf];
         if( c == EOF)
            break;

         p        = buf;
         sentinel = &buf[ sizeof( buf)];
      }
      *p++ = c;
   }

   markdownedData = [data hoedownedData];

   if( config.add_header)
      fwrite( header1, 1, sizeof( header1) - 1, stdout);
   if( config.add_css)
      fwrite( css, 1, sizeof( css) - 1, stdout);
   else
      if( config.inline_css)
      {
         fprintf( stdout, "<style>\n");

         fq = fopen( "style.css", "r");
         while( (c = getc_unlocked( fq)) != EOF)
            putc_unlocked( c, stdout);
         fclose( fq);

         fprintf( stdout, "</style>\n");
      }

   if( config.add_header)
      fprintf( stdout, header2, config.title);

   fwrite( [markdownedData bytes], 1, [markdownedData length], stdout);

   if( config.add_footer)
      fwrite( footer, 1, sizeof( footer) - 1, stdout);

   return( 0);
}
