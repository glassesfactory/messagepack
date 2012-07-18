package org.messagepack.serialization
{
    import flash.utils.ByteArray;

    import org.flexunit.asserts.*;
    import org.flexunit.async.Async;

    import org.messagepack.serialization.MessagePack;

    /**
     *  interface test.
     */
    public class MessagePackTest
    {
        [Test]
        public function testInteger():void
        {
            var t:int,
                r:int,
                b:ByteArray,
                e:Array = [
                    0,
                    1,
                    10,
                    100,
                    1000,
                    10000,
                    int.MAX_VALUE,
                    -1,
                    -10,
                    -100,
                    -1000,
                    -10000,
                    int.MIN_VALUE,
                ];

            for each (t in e) {
                b = MessagePack.encode(t);
                r = MessagePack.decode(b);
                //b.position = 0;
                //trace(MessagePack.rawBytesToHexString(b));
                assertEquals(r, t);
            }
        }

        [Test]
        public function testString():void
        {
            var t:String,
                r:String,
                b:ByteArray,
                e:Array = [
                    "",
                    "asdf",
                    "asdf1234",
                    "!@#$%^&*()",
                    "あーてすてす",
                    "あいう眉幅",
                ];

            for each (t in e) {
                b = MessagePack.encode(t);
                r = MessagePack.decode(b);
                //b.position = 0;
                //trace(MessagePack.rawBytesToHexString(b));
                assertEquals(r, t);
            }
        }
    }
}
