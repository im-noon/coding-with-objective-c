// Helpful for when you're trying to test what your app does when it faults.
// You could also just divide by zero, but that'll only work on Intel.  PPC returns 0.
#define CRASH_CODE 1
#if CRASH_CODE
    NSLog( @"forcing crash" );
    kill( getpid(), SIGABRT );
#endif
