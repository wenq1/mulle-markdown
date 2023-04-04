#ifndef mulle_testproto_version_h__
#define mulle_testproto_version_h__

/*
 *  version:  major, minor, patch
 */
#define mulle_testproto_VERSION  ((0 << 20) | (1 << 8) | 1)


static inline unsigned int   mulle_testproto_get_version_major( void)
{
   return( mulle_testproto_VERSION >> 20);
}


static inline unsigned int   mulle_testproto_get_version_minor( void)
{
   return( (mulle_testproto_VERSION >> 8) & 0xFFF);
}


static inline unsigned int   mulle_testproto_get_version_patch( void)
{
   return( mulle_testproto_VERSION & 0xFF);
}

#endif
