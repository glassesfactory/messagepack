package org.messagepack.serialization
{
    import flash.utils.ByteArray;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    import org.flexunit.asserts.*;
    import org.flexunit.async.Async;

    import org.messagepack.serialization.MessagePack;
    import org.messagepack.serialization.MessagePackEncode;

    /**
     *    test for MessagePackEncode.
     */
    public class MessagePackEncodeTest
    {
        /**
         *  null value test.
         */
        [Test]
        public function testNull():void
        {
            var t:ByteArray,
                r:ByteArray;

            t = new ByteArray();
            t.writeByte(0xc0);
            r = MessagePackEncode.encode(null);

            assertEquals(String(t), String(r));
        }


        /**
         *    bool value test.
         */
        [Test]
        public function testBoolean():void
        {
            var t:ByteArray,
                r:ByteArray,
                a:Array,
                e:Array = [
                    [0xc3, true,],
                    [0xc2, false,],
                ];

            t = new ByteArray();
            for each (a in e) {
                // create expects.
                t.clear();
                t.writeByte(a[0]);
                // create tests.
                r = MessagePackEncode.encode(a[1]);
                // 
                assertEquals(String(t), String(r));
            }
        }

        /**
         *  int value test.
         */
        [Test]
        public function testInt():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:int,
                a:Array,
                e:Array = [
                    [0, [0x00]],
                    [1, [0x01]],
                    [-1, [0xff]],
                    [32, [0x20]],
                    [-32, [0xe0]],
                    [127, [0x7f]],
                    [-127, [0xd0,0x81]],
                    [254, [0xcc,0xfe]],
                    [-254, [0xd1,0xff,0x02]],
                    [255, [0xcc,0xff]],
                    [-255, [0xd1,0xff,0x01]],
                    [1024, [0xcd,0x04,0x00]],
                    [-1024, [0xd1,0xfc,0x00]],
                    [int.MAX_VALUE, [0xce,0x7f,0xff,0xff,0xff]],
                    [int.MIN_VALUE, [0xd2,0x80,0x00,0x00,0x00]],
                ];

            t = new ByteArray();
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r))
            }
        }
    }
}
