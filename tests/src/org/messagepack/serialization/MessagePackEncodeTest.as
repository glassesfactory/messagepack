package org.messagepack.serialization
{
    import flash.utils.Endian;
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
            t.endian = Endian.BIG_ENDIAN;
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
            t.endian = Endian.BIG_ENDIAN;
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
         *  positive fixnum value test.
         */
        [Test]
        public function testPositiveFixnum():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:uint,
                a:Array,
                e:Array = [
                    [0, [0x00]],
                    [1, [0x01]],
                    [32, [0x20]],
                    [127, [0x7f]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r))
            }
        }

        /**
         *  negative fixnum value test.
         */
        [Test]
        public function testNegativeFixnum():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:int,
                a:Array,
                e:Array = [
                    [-1, [0xff]],
                    [-16, [0xf0]],
                    [-32, [0xe0]],
                    [127, [0x7f]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r))
            }
        }

        /**
         *  uint8 value test.
         */
        [Test]
        public function testUint8():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:uint,
                a:Array,
                e:Array = [
                    [128, [0xcc, 0x80]],
                    [192, [0xcc, 0xc0]],
                    [255, [0xcc, 0xff]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r));
            }
        }

        /**
         *  uint16 value test.
         */
        [Test]
        public function testUint16():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:uint,
                a:Array,
                e:Array = [
                    [256, [0xcd, 0x01, 0x00]],
                    [512, [0xcd, 0x02, 0x00]],
                    [4096, [0xcd, 0x10, 0x00]],
                    [8192, [0xcd, 0x20, 0x00]],
                    [16384, [0xcd, 0x40, 0x00]],
                    [32768, [0xcd, 0x80, 0x00]],
                    [65535, [0xcd, 0xff, 0xff]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r));
            }
        }

        /**
         *  uint32 value test.
         */
        [Test]
        public function testUint32():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:uint,
                a:Array,
                e:Array = [
                    [65536, [0xce, 0x00, 0x01, 0x00, 0x00]],
                    [2147483647, [0xce, 0x7f, 0xff, 0xff, 0xff]],
                    [4294967295, [0xce, 0xff, 0xff, 0xff, 0xff]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r));
            }
        }

        /**
         *  uint64 value test.
         */
        [Ignore("flash cannot handling uint64 values...")]
        [Test]
        public function testUint64():void
        {
        }

        /**
         *  int8 value test.
         */
        [Test]
        public function testInt8():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:uint,
                a:Array,
                e:Array = [
                    [-33, [0xd0, 0xdf]],
                    [-64, [0xd0, 0xc0]],
                    [-128, [0xd0, 0x80]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r));
            }
        }

        /**
         *  int16 value test.
         */
        [Test]
        public function testInt16():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:uint,
                a:Array,
                e:Array = [
                    [-129, [0xd1, 0xff, 0x7f]],
                    [-256, [0xd1, 0xff, 0x00]],
                    [-512, [0xd1, 0xfe, 0x00]],
                    [-1024, [0xd1, 0xfc, 0x00]],
                    [-16384, [0xd1, 0xc0, 0x00]],
                    [-32768, [0xd1, 0x80, 0x00]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r));
            }
        }

        /**
         *  int32 value test.
         */
        [Test]
        public function testInt32():void
        {
            var t:ByteArray,
                r:ByteArray,
                u:uint,
                a:Array,
                e:Array = [
                    [-65536, [0xd2, 0xff, 0xff, 0x00, 0x00]],
                    [-1073741824, [0xd2, 0xc0, 0x00, 0x00, 0x00]],
                    [-2147483648, [0xd2, 0x80, 0x00, 0x00, 0x00]],
                ];

            t = new ByteArray();
            t.endian = Endian.BIG_ENDIAN;
            for each (a in e) {
                t.clear();
                for each (u in a.pop()) {
                    t.writeByte(u);
                }
                r = MessagePackEncode.encode(a.pop());
                assertEquals(String(t), String(r));
            }
        }

        /**
         *  int64 value test.
         */
        [Ignore("flash cannot handling int64 values...")]
        [Test]
        public function testInt64():void
        {
        }
    }
}
