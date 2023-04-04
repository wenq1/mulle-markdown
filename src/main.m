#define _DEFAULT_SOURCE

#import "import-private.h"

#include "mulle-testproto-version.h"

#include <stdio.h>


@interface MulleBaseAnimal: NSObject {
}

- (NSString *) speak;

@end

@implementation MulleBaseAnimal

- (NSString *) speak
{
        return @"I love beer";
}

@end

@class MulleVersatilityProtocolClass;
@protocol MulleVersatilityProtocolClass
- (NSString *) perform;
@end

@implementation MulleVersatilityProtocolClass
- (NSString *) perform {
        return @"I can jump over the hoop";
}
@end




@interface MulleBelgiumDog: MulleBaseAnimal {}
- (NSString *) speak;
@end

@implementation MulleBelgiumDog

- (NSString *) speak
{
        return @"J'aime Leffe";
}

@end





@interface MulleGermanDog: MulleBaseAnimal<MulleVersatilityProtocolClass> {}
- (NSString *) speak;
@end

@implementation MulleGermanDog

- (NSString *) speak
{
        return @"Ich liebe Weissbier";
}

@end

int main (int argc, char *argv[])
{
        MulleBaseAnimal       * baseAnimal      = [[MulleBaseAnimal alloc] init];
        printf ("baseAnimal.1: %s\n", [[baseAnimal speak] UTF8String]);

        MulleBelgiumDog       * belgiumDog      = [[MulleBelgiumDog alloc] init];
        printf ("belgiumDog.1: %s\n", [[belgiumDog speak] UTF8String]);

        MulleGermanDog        * germanDog       = [[MulleGermanDog alloc] init];
        printf ("germanDog.1: %s\n", [[germanDog speak] UTF8String]);

        printf ("germanDog.2: %s\n", [[germanDog perform] UTF8String]);

        return 0;
};
