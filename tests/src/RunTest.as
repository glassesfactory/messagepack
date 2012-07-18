package
{
    import flash.display.Sprite;

    import org.flexunit.internals.TraceListener;
    import org.flexunit.runner.FlexUnitCore;
    import org.flexunit.runner.Request;

    import org.messagepack.serialization.AllTests;

    [SWF(width=320, height=240, frameRate=60)]
    public class RunTest extends Sprite
    {
        private var core:FlexUnitCore;

        function RunTest()
        {
            core = new FlexUnitCore();

            core.addListener(new TraceListener());
            core.run(Request.classes(AllTests));
        }
    }
}
