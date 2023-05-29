# VariableBlurView

I spent some time reverse engineering iOS's variable blur effect. This sample project demonstrates how to recreate it using the private CoreAnimation/QuartzCore type, `CAFilter`.

Because `CAFilter` isn't exposed as API, use this at your own risk.
