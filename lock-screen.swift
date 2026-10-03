import Darwin
// Same macOS lock operation used by the login menu. No background service.
guard let h = dlopen("/System/Library/PrivateFrameworks/login.framework/login", RTLD_LAZY),
      let symbol = dlsym(h, "SACLockScreenImmediate") else { exit(1) }
let lock = unsafeBitCast(symbol, to: (@convention(c) () -> Int32).self)
exit(lock())
