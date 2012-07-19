package org.messagepack.serialization
{
    import flash.utils.ByteArray;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    import org.flexunit.asserts.*;
    import org.flexunit.async.Async;

    import org.messagepack.serialization.MessagePack;
    import org.messagepack.serialization.MessagePackDecode;

    /**
     *    test for MessagePackDecode.
     */
    public class MessagePackDecodeTest
    {
        /**
         *    null value test.
         */
        [Test]
        public function testNull():void
        {
            var r:ByteArray;

            r = new ByteArray();
            r.writeByte(0xc0);

            assertNull(MessagePackDecode.decode(r));
        }


        /**
         *    bool value test.
         */
        [Test]
        public function testBoolean():void
        {
            var r:ByteArray;

            r = new ByteArray();
            r.writeByte(0xc3);
            assertTrue(MessagePackDecode.decode(r));

            r.clear();
            r.writeByte(0xc2);
            assertFalse(MessagePackDecode.decode(r));
        }

        /**
         *    int value test.
         */
        [Test]
        public function testInt():void
        {
            var r:ByteArray,
                t:int,
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

            r = new ByteArray();

            for each (a in e) {
                r.clear();
                for each (u in a.pop()) {
                    r.writeByte(u);
                }
                t = a.pop();
                assertEquals(t, MessagePackDecode.decode(r));
            }
        }
    }
}
